Return-Path: <stable+bounces-217070-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AN7BLTfUlGmfIAIAu9opvQ
	(envelope-from <stable+bounces-217070-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 21:48:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5257F150535
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 21:48:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CCF70304A897
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 20:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C56266581;
	Tue, 17 Feb 2026 20:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ef9Yy+Cy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271A4259CBD;
	Tue, 17 Feb 2026 20:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771361320; cv=none; b=XB3uEoIWTegiarneZBJc2LEYAY67biEeIdzKhKtZaTB9w4MJp0gijmD1YQD2040MzqjM/JDjRjTuf6aX6/poYBOfbAlJ2x9ps7vjTbEYdxlflzcl8jTBaKly2TNir9qeRMlg5UVpFX4ybBjCDgspLKoCtjQ/LAdiZnIk06P/WLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771361320; c=relaxed/simple;
	bh=q/0Bbkg2Gx7R8KN0Aej5tLDgKq2VALFREV9+A2WMVA4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Aq0ajpAo7fFaFBh/rjplweiZ4X//7yiOGzRZhe5TYj+R6XNisnKTmfsG387X/BVSSeiUW9PGyFWL4C8weZo2psWyWVyMiQV4+eAZfU+7XcMpFLuf9zXFPJEoX3BaWFcZPSUy9YYQLmcfDeNapLfg7lRz9fHRB3VBVDYpso557lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ef9Yy+Cy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90B89C4CEF7;
	Tue, 17 Feb 2026 20:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771361320;
	bh=q/0Bbkg2Gx7R8KN0Aej5tLDgKq2VALFREV9+A2WMVA4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ef9Yy+Cycc06kJch84VH7JSiMt8kqCUvp67rJNdR7v9YJ4bzbpx7Kp0a6BW7wZIkT
	 FqgSbgYptdRs6JOEdlL4OFcevmWjOQL17rx8QpxJfOK7IiKnPuBNmcvs8pDb1k4yPZ
	 qfZPTQPhNIE6Y6lkVp9LpRyxveuJDfOnKdw0JMmM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Brahmajit Das <listout@listout.xyz>,
	Thierry Reding <treding@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: =?UTF-8?q?=5BPATCH=206=2E1=2034/64=5D=20=3D=3FUTF-8=3Fq=3Fdrm/tegra=3A=3D20hdmi=3A=3D20sor=3A=3D20Fix=3D20error=3A=3D20variable=3D20=3F=3D=20=3D=3FUTF-8=3Fq=3F=3DE2=3D80=3D98j=3DE2=3D80=3D99=3D20set=3D20but=3D20not=3D20used=3F=3D?=
Date: Tue, 17 Feb 2026 21:31:30 +0100
Message-ID: <20260217200008.791628703@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260217200007.505931165@linuxfoundation.org>
References: <20260217200007.505931165@linuxfoundation.org>
User-Agent: quilt/0.69
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.96 / 15.00];
	SUBJ_EXCESS_QP(1.20)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,listout.xyz:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email];
	TAGGED_FROM(0.00)[bounces-217070-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: 5257F150535
X-Rspamd-Action: no action

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Brahmajit Das <listout@listout.xyz>

[ Upstream commit 1beee8d0c263b3e239c8d6616e4f8bb700bed658 ]

The variable j is set, however never used in or outside the loop, thus
resulting in dead code.
Building with GCC 16 results in a build error due to
-Werror=unused-but-set-variable= enabled by default.
This patch clean up the dead code and fixes the build error.

Example build log:
drivers/gpu/drm/tegra/sor.c:1867:19: error: variable ‘j’ set but not used [-Werror=unused-but-set-variable=]
 1867 |         size_t i, j;
      |                   ^

Signed-off-by: Brahmajit Das <listout@listout.xyz>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Link: https://lore.kernel.org/r/20250901212020.3757519-1-listout@listout.xyz
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/tegra/hdmi.c | 4 ++--
 drivers/gpu/drm/tegra/sor.c  | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/tegra/hdmi.c b/drivers/gpu/drm/tegra/hdmi.c
index c66764c0bd250..47f794a367ba1 100644
--- a/drivers/gpu/drm/tegra/hdmi.c
+++ b/drivers/gpu/drm/tegra/hdmi.c
@@ -654,7 +654,7 @@ static void tegra_hdmi_write_infopack(struct tegra_hdmi *hdmi, const void *data,
 {
 	const u8 *ptr = data;
 	unsigned long offset;
-	size_t i, j;
+	size_t i;
 	u32 value;
 
 	switch (ptr[0]) {
@@ -687,7 +687,7 @@ static void tegra_hdmi_write_infopack(struct tegra_hdmi *hdmi, const void *data,
 	 * - subpack_low: bytes 0 - 3
 	 * - subpack_high: bytes 4 - 6 (with byte 7 padded to 0x00)
 	 */
-	for (i = 3, j = 0; i < size; i += 7, j += 8) {
+	for (i = 3; i < size; i += 7) {
 		size_t rem = size - i, num = min_t(size_t, rem, 4);
 
 		value = tegra_hdmi_subpack(&ptr[i], num);
diff --git a/drivers/gpu/drm/tegra/sor.c b/drivers/gpu/drm/tegra/sor.c
index 77723d5f1d3fd..ce8e299b6afb6 100644
--- a/drivers/gpu/drm/tegra/sor.c
+++ b/drivers/gpu/drm/tegra/sor.c
@@ -1860,7 +1860,7 @@ static void tegra_sor_hdmi_write_infopack(struct tegra_sor *sor,
 {
 	const u8 *ptr = data;
 	unsigned long offset;
-	size_t i, j;
+	size_t i;
 	u32 value;
 
 	switch (ptr[0]) {
@@ -1893,7 +1893,7 @@ static void tegra_sor_hdmi_write_infopack(struct tegra_sor *sor,
 	 * - subpack_low: bytes 0 - 3
 	 * - subpack_high: bytes 4 - 6 (with byte 7 padded to 0x00)
 	 */
-	for (i = 3, j = 0; i < size; i += 7, j += 8) {
+	for (i = 3; i < size; i += 7) {
 		size_t rem = size - i, num = min_t(size_t, rem, 4);
 
 		value = tegra_sor_hdmi_subpack(&ptr[i], num);
-- 
2.51.0




