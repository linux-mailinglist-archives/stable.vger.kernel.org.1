Return-Path: <stable+bounces-247885-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +DyjDj5CB2oCvAIAu9opvQ
	(envelope-from <stable+bounces-247885-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 17:56:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B049B552818
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 17:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D2B8330471C0
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 15:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A623F3FF1DE;
	Fri, 15 May 2026 15:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KeSuo4B9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695BF3FF1CD;
	Fri, 15 May 2026 15:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778860322; cv=none; b=dRC8OkZpYYtxoHQ+TUMovJDWPTnlVm0+oHHd0Q04JzeYsG2HiCpcfEBnntJfE5JrENbLtdaFuM8evDixOawJ9e6Mv+A+saH1M3ytmBDZOg0e8fdEPaBMnwB2o/fVKaRXes8w+PbUbiWAF3UF7+0sFeaRLHMk+agIsbCWbzcs3fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778860322; c=relaxed/simple;
	bh=4dVT5JYZYjJqWR4XrJ0vb/MV4sWr2EJJxRgEoy6YKcU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nzP8Nt2+E4MpEidqQQckpHNNdurlKV0Uw+adnH+9gXXGNQEAdXcSG5Pb0x1OrgRTulUjN4XiELGHfrBTagu5iKDLMod0Nb/1wUAk+ezttFMBE6oSD5FbDD5VzfHGo9B0v5QbSBYSbMbM7oEYg6H279FQDwB4+aO1p8PbyHFiCO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KeSuo4B9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EABBAC2BCB0;
	Fri, 15 May 2026 15:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778860322;
	bh=4dVT5JYZYjJqWR4XrJ0vb/MV4sWr2EJJxRgEoy6YKcU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KeSuo4B97YOkgQv9Y4PvlU0WK9qc2fec+n3g2gClyo9ptwILpIoOh9KeKe9ibmeHJ
	 k/R4sDf9QNpLMBb4IFVBKKrQmjfZdjuC/RpVbBflOnggY8aqttIWrM/MRUtAhATb8r
	 WkpWe/ZckOVG1ZB1TQHDte/HEK4LzG//x3u02O/M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jai Luthra <jai.luthra@ideasonboard.com>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH 6.12 017/144] media: i2c: imx283: Enter full standby when stopping streaming
Date: Fri, 15 May 2026 17:47:23 +0200
Message-ID: <20260515154653.893741546@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515154653.469907118@linuxfoundation.org>
References: <20260515154653.469907118@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B049B552818
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-247885-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,huawei];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ideasonboard.com:email,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,intel.com:email]
X-Rspamd-Action: no action

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jai Luthra <jai.luthra@ideasonboard.com>

commit bce1349dbf6348ddee47308e2ed08878356de317 upstream.

Use IMX283_STANDBY (bit 0) instead of IMX283_STBLOGIC (bit 1) when
stopping streaming. STBLOGIC only puts the sensor logic into standby but
leaves the MIPI interface (along with other components) in an
indeterminate state.

This (presumably) causes the CSI receiver (e.g. Raspberry Pi's CFE) to
miss the LP-11 to HS transition when streaming restarts, resulting in a
hang of 10+ seconds. The issue is most visible when immediately
restarting a full-resolution stream after stopping a 3x3 binned one, so
that runtime suspend hasn't yet been triggered.

Writing IMX283_STANDBY puts the entire sensor into standby. The
imx283_standby_cancel() sequence already handles the full wakeup from
this suspended state.

Cc: stable@vger.kernel.org
Link: https://github.com/raspberrypi/linux/issues/7153
Link: https://github.com/will127534/OneInchEye/issues/12
Fixes: ccb4eb4496fa ("media: i2c: Add imx283 camera sensor driver")
Signed-off-by: Jai Luthra <jai.luthra@ideasonboard.com>
Tested-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
Reviewed-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/i2c/imx283.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/media/i2c/imx283.c
+++ b/drivers/media/i2c/imx283.c
@@ -1160,7 +1160,7 @@ static int imx283_disable_streams(struct
 	if (pad != IMAGE_PAD)
 		return -EINVAL;
 
-	ret = cci_write(imx283->cci, IMX283_REG_STANDBY, IMX283_STBLOGIC, NULL);
+	ret = cci_write(imx283->cci, IMX283_REG_STANDBY, IMX283_STANDBY, NULL);
 	if (ret)
 		dev_err(imx283->dev, "Failed to stop stream\n");
 



