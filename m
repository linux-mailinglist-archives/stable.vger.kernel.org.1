Return-Path: <stable+bounces-230068-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EPmDDj9BwmmCagQAu9opvQ
	(envelope-from <stable+bounces-230068-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 08:46:07 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A42F930420C
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 08:46:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC03C3169137
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 07:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721CF33BBD1;
	Tue, 24 Mar 2026 07:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EpxtbVP5"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC33C34253B
	for <stable@vger.kernel.org>; Tue, 24 Mar 2026 07:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774338044; cv=none; b=WVPS7hDkdMhk4HZc9y7EDHZcFH6RT35XijiGgd+2sHGqzzjQyroqoR3FuCas46RAn5JpdNSzKDyJ/ATp9LtioKxw4BGXgkaiPXuQQUSG9E8h96pAAO+Ge0Pdo3VjlRvQqqrSaxbTDQg98Djqs4CBpm1e5zuhjvZaRQQqM/1ziWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774338044; c=relaxed/simple;
	bh=oBveFmmeZZxamkKRq58M/AAuts9N2ND7yvuogM5BzPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hIWIN0E/sgS7TdydjbrEQPeNkp+cpEyCzWad5Qg1y5SczOwbuKq6vsNk4PWKAyAOKXQBRA57oVW17IBG4RLJofuYCG1Gfb0GaOuFJf40NGEgg1G+1B2G0kZGNmBo3TaQAgUxeesMNovTpJ/GVQ3jeLbAEnvhe3sJLqg8DEpc0/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EpxtbVP5; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4852b81c73aso32121425e9.3
        for <stable@vger.kernel.org>; Tue, 24 Mar 2026 00:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774338036; x=1774942836; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oBveFmmeZZxamkKRq58M/AAuts9N2ND7yvuogM5BzPo=;
        b=EpxtbVP57ZHlbKngRbI9CWkpDC5ONMME+DBtTbhuqNv0YMM6o/q0gF6Kjg4cq/OoD4
         aAXQ8zSzaFgwFG/lPJD0qLGhieEifKi19MkGAh0cHxXuGkfyQxG7FIhcxd6+vfP4GFtN
         zIE4xmca3pz0XvG9LAzulBPDkI6c0GMH+BTOUXYlVVc+h5i1aJGq6lVs8YdFtZRKuHag
         bv94oUNkvCBuPOo/IjRAcCAm1YT2+2BjvMeaS8sZCULkYpbvzt/iURWZPPQN1A/g1ADd
         rnrAUk/m4ONDNYjH3apszTZD87hZPVDlAVRZjimot6RVIhJKTttvfru5dRR7dxHdRBnH
         SxsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774338036; x=1774942836;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oBveFmmeZZxamkKRq58M/AAuts9N2ND7yvuogM5BzPo=;
        b=rGgkTMBWm//+kgWzqJFqoV8OQnPnmDLqWDpjj7ZXQiLkPb7azT35F44sjmOJls8Wne
         76Ol9er5r5N+DWrMOIJeRIi55sspggHYS2HBN8gCu1Lp2Nz+AaSoiu+Zv6ZjjF4lwX3f
         Rcxv1RfkQgB1GlJW/6j0P0fekQJ+CtfRpNCD2Oz8ufBwM/gG+LFnLAUV80Jr5hWEztgh
         U/l9tegQB3LDD9qKTRY+/zzYxZE58017oECF1gypzml7CZ8MI/UkmPwsZ3dIiQExfO6O
         N6pZZNgCmHjjS/Uz1daPHljDo5Dc0tUE23cytcD9onXJWLkktRLsgLzw5XvcVVI8QzBv
         ZPag==
X-Forwarded-Encrypted: i=1; AJvYcCXla8yYuEAt8j8xKI8waC7CxFgxP5XC/4tHw0UcVq5PFeAvVND/zCNjo8fXXtIKTkBkp6mWNjk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcQj0CDbQYtaWbMVsJGbf/dJNXWQsowk2a1+RIkBOp+QaVtLkS
	m7CoSAUU71HM5o102ZUMH/TTIxaHB62oA7j7CScE54Y+E7Liqm4U/Wxy
X-Gm-Gg: ATEYQzwP81vm2e1Go1IaD9u78b3dn/GIbO+XA8rFFfe7siFh3DMSXogAsJJPuDvu2P6
	dmBiuXUjXpgBjDxMCBORNY/6HtKdjnb2pwHqgu+fD6/RfswpNj3UOh6/2e5eFzmKKv8Ck3hALZd
	Z+366G3JJXonUaMBZQVsb4s37zw5pHnIDL+xTmj+mLDE1KmI/00VA3+K06J7bBaJzvAhy5adlfS
	GGMApdg94wlHSCoCCr/IpMuDf97vWaVbsG+Pluvcsbni3PdnWOOWcIi+v/9Jd+MZ7JAqhp/aC2J
	r0mEPLGBEQzrS5/pynozLbK63yF3HBScolr0GsHxQ10veJBIhr6MwCUT1CwzAr0MnAo9fkZP5la
	KLchmPgaTyg8CMQktIhxGDVCk8vrk7SA6JSjtR+JFRj6BA3FoH562KAkukWxnQpa8GjiZbp+XiA
	6awy93gr7XBp4fQKDUip+Jr8Yccw1Xm9S3+JYQ3q0L7oXd6hNBa0IXSA69fBs=
X-Received: by 2002:a05:600c:8b0a:b0:485:4136:99a8 with SMTP id 5b1f17b1804b1-486fee0fb9emr205573295e9.22.1774338035348;
        Tue, 24 Mar 2026 00:40:35 -0700 (PDT)
Received: from ionutnechita-arz2022.localdomain ([2a02:2f0e:ca0b:2300:58bf:ac04:dcbd:3ca0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4870f864722sm13590115e9.12.2026.03.24.00.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 00:40:34 -0700 (PDT)
From: "Ionut Nechita (Sunlight Linux)" <sunlightlinux@gmail.com>
To: gregkh@linuxfoundation.org
Cc: frederic@kernel.org,
	ionut.nechita@windriver.com,
	linux-kernel@vger.kernel.org,
	oliver.sang@intel.com,
	ptesarik@suse.com,
	rdunlap@infradead.org,
	stable@vger.kernel.org,
	tglx@linutronix.de
Subject: Re: [PATCH v2 6.12.y 2/7] timers/migration: Annotate accesses to ignore flag
Date: Tue, 24 Mar 2026 09:40:32 +0200
Message-ID: <20260324074032.9026-1-sunlightlinux@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026032135-statute-factor-34cc@gregkh>
References: <2026032135-statute-factor-34cc@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230068-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sunlightlinux@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A42F930420C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Greg,

Thank you for the feedback. I understand the issues you pointed out -
the incorrect From: header and the improper backport process.

I will take the time to learn the correct steps for submitting stable
backports and will work with kernel team on this. I'll send a
properly formatted new series once I have the process right.

Sorry for the noise.

Best regards,
Ionut

