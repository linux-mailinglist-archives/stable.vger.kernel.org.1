Return-Path: <stable+bounces-218973-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0IHpNwxXnmkKUwQAu9opvQ
	(envelope-from <stable+bounces-218973-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:57:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F5B190459
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 09C3831B4FDE
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7049C242D89;
	Wed, 25 Feb 2026 01:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rRL+WPlG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A712609C5;
	Wed, 25 Feb 2026 01:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983876; cv=none; b=PKrbuF1MnLu9gS3T4CPrY3EeAufoP02gS31YzfENCeD1Nb4OLw5qNxeZql5ooIFZKTw7SxCrRvLyULP++XPtxqb6rYlbs94RZMxkKf1gbj/jMJDq4PghRy2t+PYZLq350gFyiDpWckh54vACD1DCv73w9Zhn2DCKECwpXqXI6qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983876; c=relaxed/simple;
	bh=9zXjV5J9aC7Ogk1O9OcKVf9uBALM6/RxjJIJVq9OTtw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bt/bCpeO/vgHCJNtlHdk5VZDZCAbQoFRGP8dHDVNy/mL3Wg57tywE8PivNc6szxINjkPcmV7oHtrsGFLgj2Q1uDj6duzm5L3ZKzGEWGU9LTgCL49JXb9LMeNvK09PQKczvId3pkaT3Mo1r9kJDZYDfJ/jj+2rpsZMIVDWc/XaYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rRL+WPlG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0C32C116D0;
	Wed, 25 Feb 2026 01:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983876;
	bh=9zXjV5J9aC7Ogk1O9OcKVf9uBALM6/RxjJIJVq9OTtw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rRL+WPlGACSecf37VcdL500773KclhNe39bDED0SRUx5IFm3867hSnHPVW34dGJNS
	 b/nyR8McQzPY7elsC3Q0OI/3KUqCqn/pUQir/COPV+mpfOx0ZjzMg4yeYD+avfOqN1
	 3O/HLNfI25tN5QDUDLjw7oki+78ERiJL1jYurW00=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Alexey Minnekhanov <alexeymin@postmarketos.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 134/641] arm64: dts: qcom: sdm630: fix gpu_speed_bin size
Date: Tue, 24 Feb 2026 17:17:40 -0800
Message-ID: <20260225012352.390380458@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012348.915798704@linuxfoundation.org>
References: <20260225012348.915798704@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-218973-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_PROHIBIT(0.00)[0.0.0.240:email];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,qualcomm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,postmarketos.org:email,41a0:email]
X-Rspamd-Queue-Id: 44F5B190459
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

[ Upstream commit e814796dfcae8905682ac3ac2dd57f512a9f6726 ]

Historically sdm630.dtsi has used 1 byte length for the gpu_speed_bin
cell, although it spans two bytes (offset 5, size 7 bits). It was being
accepted by the kernel because before the commit 7a06ef751077 ("nvmem:
core: fix bit offsets of more than one byte") the kernel didn't have
length check. After this commit nvmem core rejects QFPROM on sdm630 /
sdm660, making GPU and USB unusable on those platforms.

Set the size of the gpu_speed_bin cell to 2 bytes, fixing the parsing
error. While we are at it, update the length to 8 bits as pointed out by
Alexey Minnekhanov.

Fixes: b190fb010664 ("arm64: dts: qcom: sdm630: Add sdm630 dts file")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Alexey Minnekhanov <alexeymin@postmarketos.org>
Link: https://lore.kernel.org/r/20251211-sdm630-fix-gpu-v2-1-92f0e736dba0@oss.qualcomm.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sdm630.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
index 8b1a45a4e56ed..b383e480a394d 100644
--- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
@@ -598,8 +598,8 @@ qusb2_hstx_trim: hstx-trim@240 {
 			};
 
 			gpu_speed_bin: gpu-speed-bin@41a0 {
-				reg = <0x41a2 0x1>;
-				bits = <5 7>;
+				reg = <0x41a2 0x2>;
+				bits = <5 8>;
 			};
 		};
 
-- 
2.51.0




