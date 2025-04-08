Return-Path: <stable+bounces-129884-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6379A80176
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 13:40:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D4727A7406
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 11:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B7C268683;
	Tue,  8 Apr 2025 11:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cPUszKVd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A618222424C;
	Tue,  8 Apr 2025 11:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744112237; cv=none; b=IU78lbaLuWIjpyKg/rzjFzzobO9Zvz7o59rrI0/3meSGyzoznDVifRZPFDNqWDdI4GPkfCPB9KihRPtp06laM1uQa+0yF6QBcbkkts/XbluOLgH8GcQjYw2JrSNnZW4Rywa4PNdBO4gu2clK5lnUPnYWu8sYqPRB9hUYqSJjw/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744112237; c=relaxed/simple;
	bh=g2v5LelYqM3wJPAP/0ra2t8eHhdOyQUA+WZ4FruyzMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MstZSpbbfnJCON/ZWhod1akt3NNDKkvkTUwOwrvBRM4AKzYY9ksBZ5blYV4Mz/rYRZ+X2bWCsdxe9NZB0hHwvzGR/N4ANk6O9E+UqpEMXfZ07DAmShhsEZpQje1H3WJYZ+EHJmPPeMZwKaetVAUGwUmzP8lKTTz+Ssv6024oFRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cPUszKVd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35B05C4CEE5;
	Tue,  8 Apr 2025 11:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744112237;
	bh=g2v5LelYqM3wJPAP/0ra2t8eHhdOyQUA+WZ4FruyzMw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cPUszKVd83P8JlpmDhbba+LKZf0YgU8s9RbiU633aaUj+edVEVw2TahuvF+8dBktt
	 NxYKccMBe63foFCc3amexOWoIKs1O68BUlOAc1VoWkki7hVE6X7iUAl/cZ6az/SUtr
	 +II2Bl0bkGs0yioQg2eFkGohuVvNtMZnBwuNMRMQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 6.14 676/731] platform/x86: ISST: Correct command storage data length
Date: Tue,  8 Apr 2025 12:49:33 +0200
Message-ID: <20250408104929.991961099@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104914.247897328@linuxfoundation.org>
References: <20250408104914.247897328@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

commit 9462e74c5c983cce34019bfb27f734552bebe59f upstream.

After resume/online turbo limit ratio (TRL) is restored partially if
the admin explicitly changed TRL from user space.

A hash table is used to store SST mail box and MSR settings when modified
to restore those settings after resume or online. This uses a struct
isst_cmd field "data" to store these settings. This is a 64 bit field.
But isst_store_new_cmd() is only assigning as u32. This results in
truncation of 32 bits.

Change the argument to u64 from u32.

Fixes: f607874f35cb ("platform/x86: ISST: Restore state on resume")
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20250328224749.2691272-1-srinivas.pandruvada@linux.intel.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/platform/x86/intel/speed_select_if/isst_if_common.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
@@ -84,7 +84,7 @@ static DECLARE_HASHTABLE(isst_hash, 8);
 static DEFINE_MUTEX(isst_hash_lock);
 
 static int isst_store_new_cmd(int cmd, u32 cpu, int mbox_cmd_type, u32 param,
-			      u32 data)
+			      u64 data)
 {
 	struct isst_cmd *sst_cmd;
 



