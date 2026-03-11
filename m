Return-Path: <stable+bounces-224661-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sPpmL94zsWm0rwIAu9opvQ
	(envelope-from <stable+bounces-224661-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 10:20:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C8CE260367
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 10:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 922853190F14
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 09:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3534C3B775C;
	Wed, 11 Mar 2026 09:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="udSpR/qX"
X-Original-To: stable@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD33C3B9DB0;
	Wed, 11 Mar 2026 09:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773220538; cv=none; b=jWstZRvf9TbMNTJkH6ZerE1hMRa9foOLvjf3Wab01FeE0DjalYEfUsSQZXvrDdpkukLB0JectTS2EbSWVG0ormErsmQYC+9id/sLr+fmrfn0W/jbAJ5pDFZ5NwGnLti/qTPHvdGwI7wyzjeEYF3Sf3tke614gO9nizV5zOIsIpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773220538; c=relaxed/simple;
	bh=RUpHsS95XR7YAS15rMy/G/f8WEzjCYO4QqdO8kZrS+M=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZoDNw3TL5w2CptSvbK+t79bVWCUqQQe+DV6HQyFxgc4At+sEp69qMZPWBVrgStAhWu2C1MPtMQHxljlB9MBHpWW/+DPpq71//Gba8CCdc8bqdtDSiggD/v6UsLw+f7IeQZYmP5drWp6882HaYzWe4xHs+3qeGSfxorRHJNgsi5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=udSpR/qX; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi [91.158.153.178])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 25C5D4B3;
	Wed, 11 Mar 2026 10:14:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1773220459;
	bh=RUpHsS95XR7YAS15rMy/G/f8WEzjCYO4QqdO8kZrS+M=;
	h=From:Subject:Date:To:Cc:From;
	b=udSpR/qX9/RihyLFYD0+cNFL/m2UpxTzsnXXwetK7xRbvneerNe5o+mHYg8hDvcST
	 AdQFEATYhArM7fNZa8OP8h7kioXIVpDtq9o3GEHZXF3hqKzPInB24hid0cAgoTpcks
	 wTvLAofkcw1Atm/TWnkQy5BWThJ/3XyK9Y8hzSSM=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: [PATCH v2 0/2] drm/tidss: Two minor fixes
Date: Wed, 11 Mar 2026 11:14:42 +0200
Message-Id: <20260311-tidss-minor-fixes-v2-0-cb4479784458@ideasonboard.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIIysWkC/32NSw7CMAxEr1J5jVE+JEKsuEfVRWgc6kUTFFcVq
 OrdCT0AyzejN7OBUGUSuHUbVFpZuOQG5tTBOIX8JOTYGIwyXlmtceEogjPnUjHxmwRHla7OBme
 NT9C8V6WjaFo/NJ5YllI/x8Wqf+m/tVWjQiJHnvQlOO/vHClIyY8SajyPZYZh3/cvAVb7ELkAA
 AA=
X-Change-ID: 20260311-tidss-minor-fixes-c0f853a5326f
To: Jyri Sarha <jyri.sarha@iki.fi>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Sam Ravnborg <sam@ravnborg.org>, 
 Javier Martinez Canillas <javierm@redhat.com>, 
 Aradhya Bhatia <a-bhatia1@ti.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Devarsh Thakkar <devarsht@ti.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, stable@vger.kernel.org
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=868;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=RUpHsS95XR7YAS15rMy/G/f8WEzjCYO4QqdO8kZrS+M=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBpsTKqmXfj01wpJ92elveam3QNcw5WTKCKhZNmN
 GocCL85kbuJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCabEyqgAKCRD6PaqMvJYe
 9YyOD/45pqPfSFM+gBM+5qiGO3Xp1G8UW2zlM66ryjZ+vjp/bz4KYtEz5wDP4IljIYDKqJ921DF
 V5Dbf0caIMI/MksAspDF5vbkdhhHUUvBX4oHWSpezXB59VPHtNPE7ksz3PeLF8xd4FoCXN2m1AI
 KERPAgpErLPB84MAuqN5Aab6G04A+Zh3xAdEDACTzkJyhZl4tqMF5ceDEAFXyfeLEnEIcH1EU0E
 7wRQn7kO7QejMjXhZqUto2tLOefuvGwiIqxWhUK5o6EPZ/fncHXyUE0H1XiUHEgd2ICZ+tKP5XX
 YEBa/VE6tzJhUToyYBGVGpAZriFH3FLIWaWYLTg9MiiNTBoCgPvxaqmISwOIRQHsTaTY/9nPZcJ
 RbsJwjlb08KacjE1IhcesuHSXaLh07ILuyvWyqOOlDdc53iREz+ZaHjOj6M1dkmaBVxLRVHM0eY
 SQU+9tqQT7M1FlR+Xp59+dOeFCU2qvfV9/1ZA7CrWqJAtdjykwAOgs7oKwkUjOIAZQBTS612UW9
 ic1yHTvGOAQd5FUsScJY8NdwvkhrqaGCcB4zAHbhJFZVi7Xd1IHjgh/pzAV2a3TWVwJbXTkcr1W
 n/yRKcDkpZMtz1/acrfR8PuTKWRa1MtkZLxWhUS6MqJ/DQqGMcvPP8w7hSrVbrlvb76dAiPg+/Y
 y1Q1cv04QJZJ4lg==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5
X-Rspamd-Queue-Id: 2C8CE260367
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ideasonboard.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ideasonboard.com:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[iki.fi,linux.intel.com,kernel.org,suse.de,gmail.com,ffwll.ch,ravnborg.org,redhat.com,ti.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224661-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tomi.valkeinen@ideasonboard.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[ideasonboard.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ideasonboard.com:dkim,ideasonboard.com:email,ideasonboard.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Two minor fixes. One to drop an extra drm_mode_config_reset() call,
another to fix a "Missing drm_bridge_add() before attach" warning print.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
Changes in v2:
- Fix incorrect title for the second patch
- Add Maxime's acks
- Link to v1: https://lore.kernel.org/r/20260311-tidss-minor-fixes-v1-0-ee5e6e14a566@ideasonboard.com

---
Tomi Valkeinen (2):
      drm/tidss: Drop extra drm_mode_config_reset() call
      drm/tidss: Fix missing drm_bridge_add() call

 drivers/gpu/drm/tidss/tidss_encoder.c | 2 ++
 drivers/gpu/drm/tidss/tidss_kms.c     | 2 --
 2 files changed, 2 insertions(+), 2 deletions(-)
---
base-commit: 11439c4635edd669ae435eec308f4ab8a0804808
change-id: 20260311-tidss-minor-fixes-c0f853a5326f

Best regards,
-- 
Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>


