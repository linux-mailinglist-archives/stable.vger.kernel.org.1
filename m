Return-Path: <stable+bounces-253952-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MBJ2OL/DEWpDpgYAu9opvQ
	(envelope-from <stable+bounces-253952-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 17:11:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E4A5BF934
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 17:11:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A65FD3006447
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 15:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B8E5303A0D;
	Sat, 23 May 2026 15:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kyS8qk7+"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D852F7AD2
	for <stable@vger.kernel.org>; Sat, 23 May 2026 15:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779549114; cv=none; b=kCXvbdDYN1pqQ2c/t0+5kyPasZ3NqqsuTuPGtHPjgXuvxifyGfHP1SmUlhscixuc0eZRqJzyy7/AhcmXV2Z11alwrCE7lpak4mpBYtn3/voY2Q0EgAcVx+lixxnY2D5l7AXsV3/S7N/hw2OAHx8z0mk0kGolWtI+93WPTMNyU+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779549114; c=relaxed/simple;
	bh=JJhs7PUZUuC935hqyCTc38KzzpT0bwtRxfLZ6/wYq/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hcfqhbjkUwkPcdtNxgeT66TT8KN5Zp78MYS/3njTuiaLYuWi08NnASU6JVdFTt4hD8vZmSe4iEEu7OVLh4L16HVYXRhNyXkPvcFgcNhRj2PORBOeCa8/3lcrXRa8/Vf7zIWE/aoh1u2ZmGYgYLRBPgtR+fGbQXfMEy+ys+v0xns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kyS8qk7+; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-45e8a834cc2so4216109f8f.1
        for <stable@vger.kernel.org>; Sat, 23 May 2026 08:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779549109; x=1780153909; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GVuj8i39CNd2OnE6+LZlzBZ3d9svD8GeaE/Z5pzjuck=;
        b=kyS8qk7+e+/jh9vT5X4AsJ80OeRe0Y9IYHdvMqsXgKipx3NBGg5dS+T0IiM3MajzxV
         0uglI1yMF453tk3OSI6z22xjchQbJQsl4q2L9pV6xW5uD+c+qYM3XEsBdjHy/qouLTiQ
         CywY/VlNfSHdl7fRj/yJz/cVQfR03uXWSNqD+WXSN9b2gelmbP+JSxktPvafQyEdMfoZ
         DgJKChEmqYv4qBGAvRNZACbRkZXXz9P2LHA38KwVJOJvnAmPYjWEE/jXYL6VSoVaXEt5
         fR1Fx10DtVy1IsoDtBg1l5AvdukIVGSMPK3aEireQW5R0haZiSjbI4lDMSAHGTkLOixu
         Wy5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779549109; x=1780153909;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GVuj8i39CNd2OnE6+LZlzBZ3d9svD8GeaE/Z5pzjuck=;
        b=jBsCJ0vrYtu7xk+2tpUwpSwOVID1UWjcp1Ovb8TJ/JdrVVX4JwNjdYzRqSo59lG2us
         lq2EUcIubd7UxnI1hwzY5x0VYV7OI1/Ed5s9zgRkSJmZHpbHrEdFR2w7q4zbb/sR6ZSO
         EBvmtXkCcJyHs1T9fDCkTkdKJLIBZDghwn4E/5PKrvgu5AzKAQ3s8p5avThkiJocg/nL
         RGfljE0nEawSQ9UeiZ7KAbSwxNQwErrJEU8Aji8Ol6dDFy0CcI5hKxyg0z8jynh+bu20
         GkYVjj7PbwsMbErt1GZqLOfjLkj7eH7hX+nhOguWeijpf6KFi/fBa4e+wzdWngsxOKLU
         3BXg==
X-Forwarded-Encrypted: i=1; AFNElJ///xFzE9QQYemQ7BxTavH1M4RsXDQAxubKzmhcVMYF1/xbGWJpdxGZYeic4Fc8hKfk7MZsThI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsRvYMcATZ0iEnHnSKJTWo378+rMuUzPp7+y24CZPsh+VrfrLv
	VrfYrq+tGic33z2+pSyIcqMFT7pZNlof7TA5u2vSfjUV5hSG11wYtFL7
X-Gm-Gg: Acq92OGCMS8YIGraOYqfbVJrwxvTu381BbvmZXUbF6qA2szzDR7YrKo5Cf+y8qzeql4
	nW49YYz+gjD61WqA+8NjfoZJXCUfewEkz5sDwoJsRSxW41vx1WjFHfXWHCdREp5Rfxxb/+i9/+/
	cP5OvuJl/4sV5BgfEl5OrqlGYFL3uGs5trPdvLcRwHOsebttpKwf/N/e84LnToAgtS4LhOudrLs
	UpvVnyNeoCBsEX676CVzfcFDeUVv1Gcy0kJlV4sfW88bMRv8Eg1CAykn+5CljzgoYThZJetuopV
	t836AbuBeGeoIJpLE2J0D9nry2Zu1Uh+OZRPjV1duKuogOWQ7p0OucK63p5ZINzBmnp2hlb3d85
	/3t4/nptoOk+jiWtJ1zDoNOdYlT7IuF1cw5nAfgHAbG2gFdDl9veDZZm62LVs7qIU9hPVlbaJEI
	4/jafY1RXLtDLtz0Gicyn99duhiXaN9Ev/
X-Received: by 2002:a05:6000:26c3:b0:45d:b14b:23fb with SMTP id ffacd0b85a97d-45eb369c7abmr13363260f8f.11.1779549109378;
        Sat, 23 May 2026 08:11:49 -0700 (PDT)
Received: from mini.main.internal ([2a02:908:c211:cd18:36:c98d:902c:348d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6d7167dsm12629156f8f.35.2026.05.23.08.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 08:11:48 -0700 (PDT)
From: Goetz Goerisch <ggoerisch@gmail.com>
To: gregkh@linuxfoundation.org
Cc: ggoerisch@gmail.com,
	herbert@gondor.apana.org.au,
	herve.codina@bootlin.com,
	linux-crypto@vger.kernel.org,
	miquel.raynal@bootlin.com,
	paul.louvel@bootlin.com,
	sashal@kernel.org,
	stable@vger.kernel.org,
	thomas.petazzoni@bootlin.com
Subject: [PATCH 0/5] crypto: talitos - fix rename first/last to first_desc/last_desc
Date: Sat, 23 May 2026 17:10:43 +0200
Message-ID: <20260523151048.14914-1-ggoerisch@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <2026052212-aged-amply-7bd8@gregkh>
References: <2026052212-aged-amply-7bd8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-253952-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,gondor.apana.org.au,bootlin.com,vger.kernel.org,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ggoerisch@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 89E4A5BF934
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Commit a1b80018b8cec27fc06a8b04a7f8b5f6cfe86eae
was backported to 6.6.y with a866e2b1c65edaee2e1bb1024ee2c761ced335f8
It renames last to last_desc but misses one occurrence which leads to compile errors on mpc85xx

drivers/crypto/talitos.c: In function 'ahash_digest':
drivers/crypto/talitos.c:2204:16: error: 'struct talitos_ahash_req_ctx' has no member named 'last'
 2204 | req_ctx->last = 1;
      |        ^~~~

Instead of renaming req_ctx->last, commit 9826d1d6ed5f8 ("crypto: talitos - stop
using crypto_ahash::init") should be applied.
Ideally before commit 00463d5f864a ("crypto: talitos - fix SEC1 32k ahash
request limitation") to avoid any compilation breakage and ensure correctness of
the code.
 
> > Greg could you please backport the mentioned commit to 6.6.y in the correct order for the next update?

> Can you send a series of backported patches in the correct order for us
> to apply, so we know to get them correct?  Trying to dig out from an
> email like this is usually quite easy to get wrong :)

Hope this is correct.
Goetz

Eric Biggers (1):
  crypto: talitos - stop using crypto_ahash::init

Goetz Goerisch (2):
  Revert "crypto: talitos - rename first/last to first_desc/last_desc"
  Revert "crypto: talitos - fix SEC1 32k ahash request limitation"

Paul Louvel (2):
  crypto: talitos - fix SEC1 32k ahash request limitation
  crypto: talitos - rename first/last to first_desc/last_desc

 drivers/crypto/talitos.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

-- 
2.54.0


