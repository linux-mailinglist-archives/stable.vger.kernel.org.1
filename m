Return-Path: <stable+bounces-213376-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GNkTD2Y/g2kPkQMAu9opvQ
	(envelope-from <stable+bounces-213376-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 13:45:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B077EE5F67
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 13:45:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 965343003984
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 12:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A25540756B;
	Wed,  4 Feb 2026 12:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="SrILEarZ"
X-Original-To: stable@vger.kernel.org
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D65E3F23D1
	for <stable@vger.kernel.org>; Wed,  4 Feb 2026 12:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770209122; cv=none; b=TsBbbFo5da348JpzGg3DurcAJ8Z6CW0PRu17nuSnBbOxX5CuIFQeVP0tunB1T2ccPMTqIG5XGsjSm/UbL4e9Zhmg3HuFdAV0LWvuGVZSAO5DKTUyQ4DkMWXTDtJPin8CHnC7SE3p7BB1VjCNecvhKo2bnZiOZjC0G/AxS0VApSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770209122; c=relaxed/simple;
	bh=TXbXzaSWLwgamhkdYSO/p/i+/dcLpNNRMeVkd0FGjkw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CN+hHHCgVJa9KizFGajCKuz+3nHT1zuIOn4aEYTkGVipV0fQVEEa0qlGLfQ3zeJ1QDsZDSIUrw7xZWfgQgQlrgRAOHsr8At96i31BM62ljEakmf3RXYF8XaiK2r+RTRdtrh4vhSUHQCtwLKgwcTjWI7OvUzEN52bImIv1+5zpa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=SrILEarZ; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1770209090;
	bh=ew/3GQs9rP7l4OsQh4buryjn3fIw6CS1osVJC0pHQ+4=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=SrILEarZSy1zhYQpPa5UoEieOaBhC5sq2jUxcnzTMEAzeXX5bJNf0gB8B3Enkokni
	 5Qe+Zddl7y1/lgFwRHX78tJQda2xRDnbsIsU6kEXyoWR/8Ii8ME8U8v2V7T5XiDDqR
	 sC8ZM/498u2+C4kUNauZjMAvRpEmrEfuj0fIUJL4=
X-QQ-mid: zesmtpip3t1770209071t021841ab
X-QQ-Originating-IP: DBOxyTCCXQi2AF0nmme407kDyM+GY1pXNqSN+eRWKgw=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 04 Feb 2026 20:44:29 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 9890903274790844295
EX-QQ-RecipientCnt: 9
From: Wentao Guan <guanwentao@uniontech.com>
To: gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org,
	sashal@kernel.org,
	Alex Deucher <alexander.deucher@amd.com>,
	Wen Chen <Wen.Chen3@amd.com>,
	Fangzhi Zuo <jerry.zuo@amd.com>,
	Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Wentao Guan <guanwentao@uniontech.com>
Subject: [PATCH 6.6] drm/amd/display: use udelay rather than fsleep
Date: Wed,  4 Feb 2026 20:43:45 +0800
Message-Id: <20260204124345.1299227-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: Mdzq5KKjB4cUevMG0BkKjUUByNhrRGlMnTlrp9hzwDPFKhcalzCoCtLt
	U6Lwqaj9jTLiE+11pBJoK+je/z1KwvFohLZldOVjbIA6ZOI5VpkVr731D02S8/SBjxIocVk
	4WIa16xm0SBHs3cAw9HhPFGP09bRyzugNF0t+ummhS05GnvcRS7qZl/okfRLLT2GRK1tgwt
	4iZHko+d36NiuIZcGM/WhSAkLDscNIau4zJHPvZux05QblanEEJ+XNk/muVSoW6otU8FlA0
	uwnGS/6grw+Bb9FdXdqC/1SWSoqV5lHEjnicl3PPArVVB9BdvDN4L15LlBOZfbl+gNoCzTs
	MOOD+Jbhmr5BJph0r73PH+M3+TpkMal0KB2BZrFzDvjEw6biKwXYgj5EMzsxumRTrLv9OZi
	zbolZDBTule48oFusshVAbHeHvPfdDFetDpc+k6KTlHl1okaOp9D/ZDnFxJRdBa5zD0LZeY
	OoDdySQul/OV2oh0MrHPf4wEHK9/D1SnrXi82b8D0x1UKCRc86EcH5l7k+b2BDq0ljZr4kZ
	mmFMFRkdwTOpoCK5MtQTIB68Ru/DibkDULFT7sg8MfarAYiiC3UL2ZTB+eZf0q5UXSHLYv2
	YPnRC6QX81Fzl3bEunMO/3ROiFxTiVLTzGOULQnzV5F1pczJfurkBL4v/EonvLLDA4jDE6d
	olm3FPq7wy3YvkPVuqK0/ANOHwLWJmKAdXQtC82fXrUChLGGmQw8hvOmrTPYEc50oRQsS4X
	2vKiw566WIDPto/MaiSq/vDlOZ6zfoGvGnViRoA5Xs4Ff19MY9QdiNBTVRV9HTwORPgUrYK
	tftuk/8YWrFFVUdnE3KSjChFIFn0+ZbA9zD9qnSMovNT27H1ag7+NdHRTLVrhVEziGCWRrl
	FzCZvjA2M7pQSPsdDyQ0guAPMRrF2i0d1GkmbBoUbK1hHwLsuDkITgNNejiuPAWqM15psnI
	l0r2HlVUEwFdNCesytFXo785GHhnOqm/7U2cor/wdc+cuycOuUh7TUtSESfj3+Umclw69X/
	kEVeKSLn4I35A0mlWpdMU/0KJCDrZOLIih0Btd//EI4ZXl6Xg6zWrKcF30c21bNiG7D/D9d
	tEZFQKdk+Fh
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-213376-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[uniontech.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guanwentao@uniontech.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,amd.com:email]
X-Rspamd-Queue-Id: B077EE5F67
X-Rspamd-Action: no action

From: Alex Deucher <alexander.deucher@amd.com>

commit 27e4dc2c0543fd1808cc52bd888ee1e0533c4a2e upstream.

This function can be called from an atomic context so we can't use
fsleep().

Fixes: 01f60348d8fb ("drm/amd/display: Fix 'failed to blank crtc!'")
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4549
Cc: Wen Chen <Wen.Chen3@amd.com>
Cc: Fangzhi Zuo <jerry.zuo@amd.com>
Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
[ Backport for file path changed ]
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index f0b472e84a53d..e52c2bb1b6265 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -781,7 +781,7 @@ enum dc_status dcn20_enable_stream_timing(
 		return DC_ERROR_UNEXPECTED;
 	}
 
-	fsleep(stream->timing.v_total * (stream->timing.h_total * 10000u / stream->timing.pix_clk_100hz));
+	udelay(stream->timing.v_total * (stream->timing.h_total * 10000u / stream->timing.pix_clk_100hz));
 
 	params.vertical_total_min = stream->adjust.v_total_min;
 	params.vertical_total_max = stream->adjust.v_total_max;
-- 
2.30.2


