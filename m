Return-Path: <stable+bounces-233571-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QB8AAJzs1GkjywcAu9opvQ
	(envelope-from <stable+bounces-233571-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 13:38:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F74F3ADCC2
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 13:38:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E8FBF301A718
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 11:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E8D3AE199;
	Tue,  7 Apr 2026 11:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="RbQn6PNa"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5816A399359
	for <stable@vger.kernel.org>; Tue,  7 Apr 2026 11:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775561868; cv=none; b=CVOlOBE/pjOqHDyWlTF5Z0RieAJrDprqNeNbVhzXyGLVLIX/MzecofEbSfzQb4F3WK4PAbWeR2+tqIGoI9/GoTaewH/eoMsKsPM8h2GrQkfldCXDevBIeWVUcCFDtTh1S7yWLM0djwFMGx38slKYOO1xpvUk80NionyjEyoL760=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775561868; c=relaxed/simple;
	bh=WCKsEfwpd8NFt9JIUnoE7tuNVYm8yPOjMH5BRZVo5/I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E3CRjQoSpIcJpaH4ScrBYfQJa87sNA+ESExpnh2nH5Eui5SH12HLxcz63WBsILboegOFvX80rF4VzZrTqpvqEE3EUBm60LoTXGY/2Hjww2ZzbDO9qErO2o+x4ftQVzQm4sVYMUy3MplQnAGFaVHQ71aAHLdoyFUhNYzcifQNW7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=RbQn6PNa; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43cf3ee0fc1so3976334f8f.1
        for <stable@vger.kernel.org>; Tue, 07 Apr 2026 04:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1775561864; x=1776166664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xJPoxZ1EOrAXmYyI9hg0ZLY3To2UTTnl1xF8UcdE86A=;
        b=RbQn6PNafeeq47Earb/eAF0nf2HvG7Sn33Q+S+Q/4f0EwcFGHUgD3lRRnYmw1IQomP
         FqxiiGzzLbRAKTgs8SrCfPByx3nz3iBMqiwg7w9dYQImUwvyjPkhSCpZW2RLza2yCRPS
         s16wq/L7h9Ah1BNiqFliRaN7geOoSxb8hCMaOXsuBI+P6HqWSSWYsU6yWPEUAxeX9igq
         UIkwrm7mZeS9BS+Zs0utz/sMQ7lD7SCBlCWLBM/u12eET1vdeT8KC1v5mlj/4gyMiRH1
         pXsfQ52wuTsBq5FK4dbdqmT2R7YAsKlIgNNOgYPm23H9j9SB+1tq0L84V+qpSygpUZZD
         ZnQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775561864; x=1776166664;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xJPoxZ1EOrAXmYyI9hg0ZLY3To2UTTnl1xF8UcdE86A=;
        b=N6ObXvtbvkYCAbdSymSSvre5n75lMUxYjzSWDZWoObheoXZ5LilBDBsdHfaCpS8ARq
         /NJJgodGYY0UyEkCBu2tUfEAm5zZo9YRT1CWzaQz3TfCuPmb7wkwUE1gY20erj497BPo
         h79vAdkuWrodqjaje0LUxfFUkZhaPtFWAXiJA4BtCPlUbEnVFvkUKFYIODGbzhlZFIBC
         J5j41SJpXkEeHQyutc5mjqrQRnNJyMKLlwIn+C4Xn4gNW+bgDevlf3YywSpU4BP4N/Fc
         zJBJHgoJlbfaZQQjxD7O66blEx2/R9lkIArspBxhK2a0OFFPYFcEYyeJAtvjVkylUG1P
         Adyw==
X-Gm-Message-State: AOJu0YxCpb6p+HhRxHiznIC+mfhSyD7A4XtwdbD76GSfGGBON6J8LqC/
	8SX2+rqh7wo2Xqj5LjSfj9VdwZ2soh03Yg7fqXiqj5ykRrra5E2zMr0hy0Knrj4FtKt7pc7mCGJ
	H9WJm
X-Gm-Gg: AeBDiesFhU6PfUrbDyWHoHbmULbKExh7VHXjkwi4SEc5C+T9W2Jg/QEyLFpvyfWtLro
	MDpRrazZzLz/zmE/h5/aeYMu4fM4moRHt5oN6mbYt/JiB0ppytizlKNdfe/4DWT2SLqiWk9Rvdy
	Stupc12DO0cIHbob2vBVim2uuv5jBJdmBtUcMHyOiIvY9iqajPdmaANi1IMjBHSsTuBB12r71RE
	C0yTEbF3+rEeChQxcHf3aQFRG13nOwHEAU8M7IDhxi/OYwgorctguOk6Nb20TrC/EX2Vg+qeJII
	RMtyyDwOC0UAmwX81pJ/d5VOg6j2LkVT1VejWWrkh9DFVukwiE1rEjrcy4iIQberuo88dRk17+Q
	a77h7JGNX9erWhI4lU9+26vpYE5L4BasAc3CTUEDX03jT9Uu0HzhCzrWP7awCVIYtSNr81bOivw
	Pb4Fan4LtKZX587Zj0/qjyThw0/k6KcR/ldrpHwPVPEgEzNl5lIEMo
X-Received: by 2002:a5d:5d0a:0:b0:43b:9b0a:7e80 with SMTP id ffacd0b85a97d-43d2115aed7mr30075765f8f.3.1775561864134;
        Tue, 07 Apr 2026 04:37:44 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.248])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e2a6f13sm50527718f8f.3.2026.04.07.04.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 04:37:43 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: stable@vger.kernel.org
Cc: claudiu.beznea@tuxon.dev
Subject: [PATCH 5.10.y 0/4] phy: renesas: rcar-gen3-usb2: Fixes for Renesas GEN3 USB2 PHY
Date: Tue,  7 Apr 2026 14:37:38 +0300
Message-ID: <20260407113742.860378-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[tuxon.dev:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[tuxon.dev:+];
	DMARC_NA(0.00)[tuxon.dev];
	TAGGED_FROM(0.00)[bounces-233571-lists,stable=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FROM_NEQ_ENVFROM(0.00)[claudiu.beznea@tuxon.dev,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tuxon.dev:dkim,renesas.com:email,bp.renesas.com:mid]
X-Rspamd-Queue-Id: 6F74F3ADCC2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Hi,

Series backports fixes to the Renesas RCAR GEN3 USB2 PHY driver. Fixes
are already backported to the other stable trees.

Thank you,
Claudiu

Claudiu Beznea (4):
  phy: renesas: rcar-gen3-usb2: Fix role detection on unbind/bind
  phy: renesas: rcar-gen3-usb2: Move IRQ request in probe
  phy: renesas: rcar-gen3-usb2: Lock around hardware registers and
    driver data
  phy: renesas: rcar-gen3-usb2: Assert PLL reset on PHY power off

 drivers/phy/renesas/phy-rcar-gen3-usb2.c | 122 +++++++++++++----------
 1 file changed, 71 insertions(+), 51 deletions(-)

-- 
2.43.0


