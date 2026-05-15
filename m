Return-Path: <stable+bounces-248662-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UPigEYxOB2p3xwIAu9opvQ
	(envelope-from <stable+bounces-248662-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:49:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD68C553F82
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 696E2300F76A
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11EA53F8703;
	Fri, 15 May 2026 16:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ktpIS58T"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94FA22FF22;
	Fri, 15 May 2026 16:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778862308; cv=none; b=SY6x01yZxrPiqN6M1O3k7ne1f4uJPJ2Qz+pEpaRkIqP817yFo622x+DPUyTrC0dXJ5PYWPB4YU9gfb3XaKkoMVi9hrwg70a4xJO0HE8UfZ2Ptuo8+4RGJX4hx/Es3kCdN2Tf34t/o2QtegSdcnNlLa5Fl2nlYm4kknZXgFYqjc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778862308; c=relaxed/simple;
	bh=RELjihQgFWxZbgV9DVC+oW9GFrxdxaW65Rihfr3D7k4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bonC6DrQ/uvIfFsS9cBy54UfwT4iZfHv7q6ASCarGQvqWu7ZVS7zAIf6rvIjN8a10WelDF3L3u9Qd25VHnFpc6kDGBrIGxZcwDo6zNk0qu3q5naCVULlavtJUpXGXRyj5pgNC3Obn/tfCa1tXv7JjbTliejJD05OFs288L2eRAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ktpIS58T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59766C2BCB0;
	Fri, 15 May 2026 16:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778862308;
	bh=RELjihQgFWxZbgV9DVC+oW9GFrxdxaW65Rihfr3D7k4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ktpIS58T9jVjSvHiKURny9gBGBAL/3/jwk/F01iOzt5p0Pq6EjdeggB6BcLiY9+H5
	 XUhCCli+AH+4PGZQQwcqGiV4NamGdUMV2FBR0FQ+qi9C0HRd5AZVZ6kjZwBGu0S6ys
	 BpiDpwP4WwBYlI8sE2AI2KcCq1leae+pd0d6x5bg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	SDL <sdl@nppct.ru>,
	Benjamin Cheng <benjamin.cheng@amd.com>,
	Ruijing Dong <ruijing.dong@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.18 187/188] drm/amdgpu/vcn3: Avoid overflow on msg bound check
Date: Fri, 15 May 2026 17:50:04 +0200
Message-ID: <20260515154701.396541290@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515154657.309489048@linuxfoundation.org>
References: <20260515154657.309489048@linuxfoundation.org>
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
X-Rspamd-Queue-Id: DD68C553F82
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-248662-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,amd.com:email,nppct.ru:email]
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Benjamin Cheng <benjamin.cheng@amd.com>

commit e6e9faba8100628990cccd13f0f044a648c303cf upstream.

As pointed out by SDL, the previous condition may be vulnerable to
overflow.

Fixes: b193019860d6 ("drm/amdgpu/vcn3: Prevent OOB reads when parsing dec msg")
Cc: SDL <sdl@nppct.ru>
Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>
Reviewed-by: Ruijing Dong <ruijing.dong@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit db00257ac9e4a51eb2515aaea161a019f7125e10)
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -1971,6 +1971,7 @@ static int vcn_v3_0_dec_msg(struct amdgp
 
 	for (i = 0, msg = &msg[6]; i < num_buffers; ++i, msg += 4) {
 		uint32_t offset, size, *create;
+		uint64_t buf_end;
 
 		if (msg[0] != RDECODE_MESSAGE_CREATE)
 			continue;
@@ -1978,7 +1979,8 @@ static int vcn_v3_0_dec_msg(struct amdgp
 		offset = msg[1];
 		size = msg[2];
 
-		if (size < 4 || offset + size > end - addr) {
+		if (size < 4 || check_add_overflow(offset, size, &buf_end) ||
+		    buf_end > end - addr) {
 			DRM_ERROR("VCN message buffer exceeds BO bounds!\n");
 			r = -EINVAL;
 			goto out;



