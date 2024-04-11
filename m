Return-Path: <stable+bounces-38586-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9E98A0F65
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 12:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7AFF1F277AB
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 10:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A4B6146A82;
	Thu, 11 Apr 2024 10:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zvB9WxXE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F178C14600A;
	Thu, 11 Apr 2024 10:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712831011; cv=none; b=p8Z58UOqdz0sgcGQUPTsEoJdRzVQrz2xwuPIEEBzQi9s7ULdCZ3jCfC1gUbOBKACckds2zyqcBtRWob5dBZxbZVnzWVHoVFs95cLaIeZuM64lGkH8Ti9rm3PJCeR82offIuoZbMhLBrflGmuTO0s1cutvJcoAk20YMqinnH58kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712831011; c=relaxed/simple;
	bh=HdWhHyH/r04Hn5igBTc4WiLML09vzKoFeKE3m+Pv5YI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=haDWuWmyfg/FbNvSviqhtcz6dGRcHjyQfg57nl3g/yn9qt19T0b+aMqI/ut2CQTnkn3ELuWr3W1KNuIn/XArCHjYRldM1TQrkkwXlkjiCW0ytgy+Qc96ms5bJBynzjGZeRYtHvyt5CLLMoX6kujqiBOAbATuk6LdyT8Y1A7ic1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zvB9WxXE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76B76C433F1;
	Thu, 11 Apr 2024 10:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712831010;
	bh=HdWhHyH/r04Hn5igBTc4WiLML09vzKoFeKE3m+Pv5YI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zvB9WxXENnaOwoYHYHQm1c28gad+x0109Tk24Y22rY/iA5hgDrBAb9f1TANfxrGD8
	 6F1YIGRBRwIRuOzeyS2HpA0K/7ixjOm2fCcEFy7qMUzIuztfJaLCfJRPBP8IDOhPSK
	 Zb4D/anvdr4uJiAKY8x2fKkiQf1SzfyuBi5LI5pI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dave Stevenson <dave.stevenson@raspberrypi.org>,
	Jacopo Mondi <jacopo@jmondi.org>,
	Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 155/215] staging: mmal-vchiq: Fix client_component for 64 bit kernel
Date: Thu, 11 Apr 2024 11:56:04 +0200
Message-ID: <20240411095429.540786685@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411095424.875421572@linuxfoundation.org>
References: <20240411095424.875421572@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dave Stevenson <dave.stevenson@raspberrypi.org>

[ Upstream commit 22e64b486adc4785542f8002c3af4c895490f841 ]

The MMAL client_component field is used with the event
mechanism to allow the client to identify the component for
which the event is generated.
The field is only 32bits in size, therefore we can't use a
pointer to the component in a 64 bit kernel.

Component handles are already held in an array per VCHI
instance, so use the array index as the client_component handle
to avoid having to create a new IDR for this purpose.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.org>
Signed-off-by: Jacopo Mondi <jacopo@jmondi.org>
Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Link: https://lore.kernel.org/r/20200629150945.10720-5-nsaenzjulienne@suse.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: f37e76abd614 ("staging: vc04_services: fix information leak in create_component()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c | 8 +++++++-
 drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.h | 1 +
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c b/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c
index 9b47ba4d2d3cd..23d869ba12e69 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c
+++ b/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c
@@ -928,7 +928,7 @@ static int create_component(struct vchiq_mmal_instance *instance,
 
 	/* build component create message */
 	m.h.type = MMAL_MSG_TYPE_COMPONENT_CREATE;
-	m.u.component_create.client_component = (u32)(unsigned long)component;
+	m.u.component_create.client_component = component->client_component;
 	strncpy(m.u.component_create.name, name,
 		sizeof(m.u.component_create.name));
 
@@ -1635,6 +1635,12 @@ int vchiq_mmal_component_init(struct vchiq_mmal_instance *instance,
 		goto unlock;
 	}
 
+	/* We need a handle to reference back to our component structure.
+	 * Use the array index in instance->component rather than rolling
+	 * another IDR.
+	 */
+	component->client_component = idx;
+
 	ret = create_component(instance, component, name);
 	if (ret < 0) {
 		pr_err("%s: failed to create component %d (Not enough GPU mem?)\n",
diff --git a/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.h b/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.h
index 4e34728d87e53..a75c5f0a770ef 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.h
+++ b/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.h
@@ -92,6 +92,7 @@ struct vchiq_mmal_component {
 	struct vchiq_mmal_port input[MAX_PORT_COUNT]; /* input ports */
 	struct vchiq_mmal_port output[MAX_PORT_COUNT]; /* output ports */
 	struct vchiq_mmal_port clock[MAX_PORT_COUNT]; /* clock ports */
+	u32 client_component;	/* Used to ref back to client struct */
 };
 
 int vchiq_mmal_init(struct vchiq_mmal_instance **out_instance);
-- 
2.43.0




