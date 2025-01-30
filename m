Return-Path: <stable+bounces-111522-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A8AA22F8D
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 15:23:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F65F3A3EFA
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 14:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87BA21E991C;
	Thu, 30 Jan 2025 14:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0xpuWACr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DEF1E8835;
	Thu, 30 Jan 2025 14:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738246981; cv=none; b=aq8QFyzgTyFggsWA9kJqE82l5j5hgbranndOLzgbII59IWsetfXk7xmMnz8Yt3HJrgnEa0kms+cDuqoZC+lvcaXGhR6VCAlhQX21F7fefMDOFowtuuZ+t1HdXHypM+ZwPCXDbKnEND4Nqdy8KHcW99jadc8FbcTKys2N7Csm/14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738246981; c=relaxed/simple;
	bh=s0hUNHEICwf/DBffMBGb7QxILNNl4V4rFbH3G0tbopw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kvO7IGj/OFB1xhnJefgBsgbKRRe4+b4314cba0aCfi0Ucm2ris0I5AFomB1IBfuecysZ4aaOmDGL1WhQhTu3A/4b664MOHpBWSM+75ZilkAJeqS1OFWNDUabfWpq4G66iMsLRs+xRqx/3YigACtDQAgy+7nzT3X2D5ygeMWKlUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0xpuWACr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A92AC4CED2;
	Thu, 30 Jan 2025 14:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738246980;
	bh=s0hUNHEICwf/DBffMBGb7QxILNNl4V4rFbH3G0tbopw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0xpuWACrahLKiKcdhUpuBqP4LVV7rqdZ+e/PsZEFt1O8nXDbcue7kbu8xfv4Mp+GC
	 B2SJAk7a8hvo0fmoctUhkY+uts/SpvaCmNn76aAWGQV+m88Kp2z/gTU6B1Or38MP9X
	 WGDbfIVt/y8vbNECzhbRZMiQE5tpgw5cFs070n0Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 5.10 042/133] iio: pressure: zpa2326: fix information leak in triggered buffer
Date: Thu, 30 Jan 2025 15:00:31 +0100
Message-ID: <20250130140144.208104976@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250130140142.491490528@linuxfoundation.org>
References: <20250130140142.491490528@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Javier Carrasco <javier.carrasco.cruz@gmail.com>

commit 6007d10c5262f6f71479627c1216899ea7f09073 upstream.

The 'sample' local struct is used to push data to user space from a
triggered buffer, but it has a hole between the temperature and the
timestamp (u32 pressure, u16 temperature, GAP, u64 timestamp).
This hole is never initialized.

Initialize the struct to zero before using it to avoid pushing
uninitialized information to userspace.

Cc: stable@vger.kernel.org
Fixes: 03b262f2bbf4 ("iio:pressure: initial zpa2326 barometer support")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Link: https://patch.msgid.link/20241125-iio_memset_scan_holes-v1-3-0cb6e98d895c@gmail.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/pressure/zpa2326.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/iio/pressure/zpa2326.c
+++ b/drivers/iio/pressure/zpa2326.c
@@ -586,6 +586,8 @@ static int zpa2326_fill_sample_buffer(st
 	}   sample;
 	int err;
 
+	memset(&sample, 0, sizeof(sample));
+
 	if (test_bit(0, indio_dev->active_scan_mask)) {
 		/* Get current pressure from hardware FIFO. */
 		err = zpa2326_dequeue_pressure(indio_dev, &sample.pressure);



