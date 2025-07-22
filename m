Return-Path: <stable+bounces-164162-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A36FCB0DE0D
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 16:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 322F856765E
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 14:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1930F2ED860;
	Tue, 22 Jul 2025 14:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xFL+KOOV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBAF72ED856;
	Tue, 22 Jul 2025 14:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753193452; cv=none; b=NFjnM6CyofVFeaAiyX+k0+sDwS0OsEyw/PNVfP1fVJGtz+jJn1krwz67gr5LA1/9xIsBY+MGwdGYZ8uoifnUKXgXVpW4/7jURTNTlg3oG1efXQL2qKnHNluUMr9vT8VdKWyM0GyQ3N6xggI+gRpLK0e3p3UrSwtu3I+Emh9qI+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753193452; c=relaxed/simple;
	bh=0hPjvl32p1oMfMP0C2SgR/z9rXjhtKTF+zYfAF/5kbg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b2OARur+bCF7X7Llt90GiokpvNEL2VH1D9ucdNw95N2jeD5KVvNFVaNiLbAyFzyPfeYOjv1sCuTcokY4MY6Q6StOR917Qvf8zjqTswM2JfDI/ij5auUwaR8yVUN/VGyo65sAgKHdZtHbHlUlgJfHHAFEm2BgdO2ZS8vCabvvuJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xFL+KOOV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D52F8C4CEEB;
	Tue, 22 Jul 2025 14:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753193452;
	bh=0hPjvl32p1oMfMP0C2SgR/z9rXjhtKTF+zYfAF/5kbg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xFL+KOOVqETmjW8Pm5xmGwvcg3nHIBi0F3/mMn/TNq6Tk7E14eAOZh9oI3Ena0NBo
	 IwjVSc2R0tmT75+wUNd+9745mByOXQ3+sOO6axpKKseami/fDj0cddf5OOnGptRx/i
	 keTR6viiX+Ity29MDCEBuwAYcGSokvpjzK1xALzw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ian Abbott <abbotti@mev.co.uk>
Subject: [PATCH 6.15 096/187] comedi: Fix initialization of data for instructions that write to subdevice
Date: Tue, 22 Jul 2025 15:44:26 +0200
Message-ID: <20250722134349.345406669@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250722134345.761035548@linuxfoundation.org>
References: <20250722134345.761035548@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ian Abbott <abbotti@mev.co.uk>

commit 46d8c744136ce2454aa4c35c138cc06817f92b8e upstream.

Some Comedi subdevice instruction handlers are known to access
instruction data elements beyond the first `insn->n` elements in some
cases.  The `do_insn_ioctl()` and `do_insnlist_ioctl()` functions
allocate at least `MIN_SAMPLES` (16) data elements to deal with this,
but they do not initialize all of that.  For Comedi instruction codes
that write to the subdevice, the first `insn->n` data elements are
copied from user-space, but the remaining elements are left
uninitialized.  That could be a problem if the subdevice instruction
handler reads the uninitialized data.  Ensure that the first
`MIN_SAMPLES` elements are initialized before calling these instruction
handlers, filling the uncopied elements with 0.  For
`do_insnlist_ioctl()`, the same data buffer elements are used for
handling a list of instructions, so ensure the first `MIN_SAMPLES`
elements are initialized for each instruction that writes to the
subdevice.

Fixes: ed9eccbe8970 ("Staging: add comedi core")
Cc: stable@vger.kernel.org # 5.13+
Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
Link: https://lore.kernel.org/r/20250707161439.88385-1-abbotti@mev.co.uk
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/comedi/comedi_fops.c |   14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

--- a/drivers/comedi/comedi_fops.c
+++ b/drivers/comedi/comedi_fops.c
@@ -1556,21 +1556,27 @@ static int do_insnlist_ioctl(struct come
 	}
 
 	for (i = 0; i < n_insns; ++i) {
+		unsigned int n = insns[i].n;
+
 		if (insns[i].insn & INSN_MASK_WRITE) {
 			if (copy_from_user(data, insns[i].data,
-					   insns[i].n * sizeof(unsigned int))) {
+					   n * sizeof(unsigned int))) {
 				dev_dbg(dev->class_dev,
 					"copy_from_user failed\n");
 				ret = -EFAULT;
 				goto error;
 			}
+			if (n < MIN_SAMPLES) {
+				memset(&data[n], 0, (MIN_SAMPLES - n) *
+						    sizeof(unsigned int));
+			}
 		}
 		ret = parse_insn(dev, insns + i, data, file);
 		if (ret < 0)
 			goto error;
 		if (insns[i].insn & INSN_MASK_READ) {
 			if (copy_to_user(insns[i].data, data,
-					 insns[i].n * sizeof(unsigned int))) {
+					 n * sizeof(unsigned int))) {
 				dev_dbg(dev->class_dev,
 					"copy_to_user failed\n");
 				ret = -EFAULT;
@@ -1643,6 +1649,10 @@ static int do_insn_ioctl(struct comedi_d
 			ret = -EFAULT;
 			goto error;
 		}
+		if (insn->n < MIN_SAMPLES) {
+			memset(&data[insn->n], 0,
+			       (MIN_SAMPLES - insn->n) * sizeof(unsigned int));
+		}
 	}
 	ret = parse_insn(dev, insn, data, file);
 	if (ret < 0)



