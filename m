Return-Path: <stable+bounces-224228-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ICBIGHgAsGm0eQIAu9opvQ
	(envelope-from <stable+bounces-224228-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:28:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC83924ACA6
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:28:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0424830712BD
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E95D388E62;
	Tue, 10 Mar 2026 11:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C5vHH7pT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FDB389E02;
	Tue, 10 Mar 2026 11:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773141925; cv=none; b=GeyF06+EW0ZTTsj/zNt3+NEoO2WbQeHluX/eAxFOvera/NrXywCACi1CPHpDlxIhZO7YwiiSHS6GHqAmOe4UCukzYk7q4D7LYe2BO6NrNhDuIYhhu4bVchOVL6NezfJugtGJwQrj56Vpdoh/+r+XvqKMBsaX3+Hr8dMJ2CtQb64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773141925; c=relaxed/simple;
	bh=75uQKiEqPk0+2/ZkqrB2GSYPQ3tvBpPthpZBU+7h0pM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jML7cCiyOlYnDSSWSELLL/rFDgYZeUdD3I+ga/nbc8sXXCXogk3tUabeavhwCusVF4EgSQznP0DtwUWvYXHC3D7n9kL5WBEAmijMXQPd03D5JcWUiN2QksiTrhUUJCtWxnHndJhR8gseUkwRCO2jcD78Fk4D1AMXDSb5uBOSlyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C5vHH7pT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDB80C19423;
	Tue, 10 Mar 2026 11:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773141925;
	bh=75uQKiEqPk0+2/ZkqrB2GSYPQ3tvBpPthpZBU+7h0pM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C5vHH7pTYgFAc6j/t5kHPsXfObvtaTv8EcqWoKoSBcma1mgYqjEWlhOmB3God9N9A
	 JEfxzXUA1g+X1glx+oyB/Mmt9RjkOMgSrpsrnNWPmBSN2J463g98HL7pR8X215XHdG
	 IxApbiyzZEI+gpvjRf0Na49PD4SDyUDThEc5orXXu79j6ashSdWfOqVnCqCpyTHYc4
	 s8PTqppm67lEfU5Hl0flncaq83gjPBnpWH3k+Cw5/uVE23gS7oO8X3Cp+MQpu99vfZ
	 0vWp4GQhagVnG/Un5ahjRBibJBsHvMK/j9UdyEW/CiLavTP7no9yaL38EzmhU4BOLf
	 J2fwKAOdyvm2Q==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Bart Van Assche <bvanassche@acm.org>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Yang Wang <kevinyang.wang@amd.com>,
	Hawking Zhang <Hawking.Zhang@amd.com>,
	amd-gfx@lists.freedesktop.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 049/314] drm/amdgpu: Unlock a mutex before destroying it
Date: Tue, 10 Mar 2026 07:15:08 -0400
Message-ID: <d87a5c988c7fa8aec2eebf094cb3d84adb266327.1773141555.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773141554.git.sashal@kernel.org>
References: <cover.1773141554.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: EC83924ACA6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-224228-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

From: Bart Van Assche <bvanassche@acm.org>

[ Upstream commit 5e0bcc7b88bcd081aaae6f481b10d9ab294fcb69 ]

Mutexes must be unlocked before these are destroyed. This has been detected
by the Clang thread-safety analyzer.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Yang Wang <kevinyang.wang@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Fixes: f5e4cc8461c4 ("drm/amdgpu: implement RAS ACA driver framework")
Reviewed-by: Yang Wang <kevinyang.wang@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 270258ba320beb99648dceffb67e86ac76786e55)
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
index 9b31804491500..3f9b094e93a29 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
@@ -641,6 +641,7 @@ static void aca_error_fini(struct aca_error *aerr)
 		aca_bank_error_remove(aerr, bank_error);
 
 out_unlock:
+	mutex_unlock(&aerr->lock);
 	mutex_destroy(&aerr->lock);
 }
 
-- 
2.51.0


