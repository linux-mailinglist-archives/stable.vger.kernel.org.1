Return-Path: <stable+bounces-237148-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wHg/FBsk3Wn9aAkAu9opvQ
	(envelope-from <stable+bounces-237148-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:12:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3343F1008
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DBF1A3229299
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995B3313535;
	Mon, 13 Apr 2026 16:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="v9zVrL1D"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C003314D13;
	Mon, 13 Apr 2026 16:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776098712; cv=none; b=dQdYCqCavVpC+OJrQU9j5GndjxCXW/lOtnsRnWrrZ8U+9BCVifUeZrmUHgHODjz6O7fyCAMULaVZA/pumwqNSZRUy7pf9shnq3AAfC2polAhkghmOsb8KW2C+qMUxHkM79MGdf2FvTSnW5RyaovhyiER4l++gdegiRAPA89Q1M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776098712; c=relaxed/simple;
	bh=2x/u7QJR2jDFgEnA5cFQeaFT1IFJpuA57Z7ribIBx0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ncHW+Cy99dOcnYQjdYJbs6UJG6GXUsOhb9lNvOflvBjlF4zZvOFRpbInAHLYxnL9Rj+qmnqtbd1Po2MetLYDnIbdc+U0xUc1aiUG2fT3fI9n8TEY8i6R6kw5xZ0bpwNHS4d5FhvAUSiW1/4vOoO5+PNIzFESM4ZP347ZGNmS++Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=v9zVrL1D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5D13C2BCAF;
	Mon, 13 Apr 2026 16:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776098712;
	bh=2x/u7QJR2jDFgEnA5cFQeaFT1IFJpuA57Z7ribIBx0s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=v9zVrL1D0QqFUem2ZLCz1ziA2oSSdbNXxBUJg6RePQ3C+Potla7H01327ig1x7qrl
	 EIgJn4TreqyUGrauU/z+DWkqJHm1cjUhyPiMnMoElCwTSxOzedrd3p+300qzexLURP
	 e+/aVKCq0ZM4kjv4kADbTOCGV7k1Czt4Z4Dvm5bY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
	Chris Lew <christopher.lew@oss.qualcomm.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 059/491] remoteproc: sysmon: Correct subsys_name_len type in QMI request
Date: Mon, 13 Apr 2026 17:55:04 +0200
Message-ID: <20260413155821.258804544@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155819.042779211@linuxfoundation.org>
References: <20260413155819.042779211@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-237148-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,qualcomm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AA3343F1008
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>

[ Upstream commit da994db94e60f9a9411108ddf4d1836147ad4c9c ]

The QMI message encoder has up until recently read a single byte (as
elem_size == 1), but with the introduction of big endian support it's
become apparent that this field is expected to be a full u32 -
regardless of the size of the length in the encoded message (which is
what elem_size specifies).

The result is that the encoder now reads past the length byte and
rejects the unreasonably large length formed when including the
following 3 bytes from the subsys_name array.

Fix this by changing to the expected type.

Fixes: 1fb82ee806d1 ("remoteproc: qcom: Introduce sysmon")
Signed-off-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Reviewed-by: Chris Lew <christopher.lew@oss.qualcomm.com>
Link: https://lore.kernel.org/r/20260220-qmi-encode-invalid-length-v2-1-5674be35ab29@oss.qualcomm.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/remoteproc/qcom_sysmon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/remoteproc/qcom_sysmon.c b/drivers/remoteproc/qcom_sysmon.c
index c348ea35e47c3..be3a2fa12394b 100644
--- a/drivers/remoteproc/qcom_sysmon.c
+++ b/drivers/remoteproc/qcom_sysmon.c
@@ -196,7 +196,7 @@ static struct qmi_elem_info ssctl_shutdown_resp_ei[] = {
 };
 
 struct ssctl_subsys_event_req {
-	u8 subsys_name_len;
+	u32 subsys_name_len;
 	char subsys_name[SSCTL_SUBSYS_NAME_LENGTH];
 	u32 event;
 	u8 evt_driven_valid;
-- 
2.51.0




