Return-Path: <stable+bounces-253574-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GEayA0ocD2rbFwYAu9opvQ
	(envelope-from <stable+bounces-253574-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 16:52:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A52655A7B38
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 16:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DBC0E30A3780
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 14:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 853F83D7D74;
	Thu, 21 May 2026 14:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FfH812Y/"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6EFD3DB301
	for <stable@vger.kernel.org>; Thu, 21 May 2026 14:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779373142; cv=none; b=Oe1MdMKdmGBlV8fnj4bU+6V/5cXWuNyThzkeG5imDtgUBF7lnILf1TTUIPBJ/kWsru5nRfpJGCu+C7QmKE8wPUSVS5TUFBAvWhn1EqQq865wmnySB8q/xj11wfW2TTKjdVsH6BuBbQiwwGsnGLiscz9MX5Yaqt+gM5UmjHfj//0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779373142; c=relaxed/simple;
	bh=bmeraoj28RJVVEKy0iNs2TVJQGIwMWX6sf+UVtwTJ7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hoLnRCAwmyXgacZ4noTdtNpWusyue2oEKzWS8nEiPfMJ5xm+ax141ahkCAp8ZzjW5Qfkq8KSadbxIJZQgx/fu7+mmNKw1T13EOx1DMaJAVxZNj8ur3PCqO01AuAeuwQThyOF96RAzFLf/1XdVszpMcWZ8nQxVtwpf3OSKEXZUEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FfH812Y/; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-67389cf78b0so13907046a12.2
        for <stable@vger.kernel.org>; Thu, 21 May 2026 07:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779373139; x=1779977939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bmeraoj28RJVVEKy0iNs2TVJQGIwMWX6sf+UVtwTJ7c=;
        b=FfH812Y/bfa1LT9lkKJb7TQwqFCMu5Pw6kPLADRoTeyomc6pqGg/CkKBs3/mAZQRWN
         31FpP85nGwo37rpIs594iF5+I4/+xuIEBvhkcaIm8BizhFiJB3dNcjQbE+Tr8XGfGhbH
         wECjjhBA895p13d/3oHpYXt7iqblqrYRL509NcWbmbW3+URnP2vYPSx9+sesj3UxzeEL
         3ia2T48U5866iWpsf5YG57cR3Xkku8il3Hii/RVZjBYNVbXiKAq46AXNiofR75CtCGOL
         eaLHU9axsWVZmn+SC9fkAX+sC/3mu4oTnBFARDRgdsMeuLSYsrLWLPBQTyAB/R2Q5uoa
         GWcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779373139; x=1779977939;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bmeraoj28RJVVEKy0iNs2TVJQGIwMWX6sf+UVtwTJ7c=;
        b=dDVWaqZprSFm6gb/N3/Pw5nKfn4ynPZrPXTHYwha4rOKuMRJV261wwEama/BJIGCOy
         SnlmqvUA47+aYUCXQ1hUaMBPevsYSbSaJnCQmBLt2x1AVWNCwzwd/3fe3AOshTZJ/BsH
         awhI2eqnosw3DrAFQaL7dUR0nWeVCyi2TpKlr7KVCe9Tf1j9e7704UcyLFqXKwId/86H
         G/BXrhzZ16AfLBdzqlGn1UXiRDpYQu37IDrVnsFjkaVuG8C3VOj2WxFdNwlIOtHC/U4L
         958FOWngTR39lw2l21S8XZ0dRHZD3qELj0Ow2vHQ9JNJQuXd1znVy4qBqGyM7IdwY1hE
         Lwng==
X-Forwarded-Encrypted: i=1; AFNElJ+xnE4UVXFSg8x99OPKyKcb1GA90dgrbjhBc+5gA5qSeOFtxz9/olHYqxMsFm5VgG5yFrljp1U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB+OCHZAmIQCEDvP9eCp8rAR0Y+MoZMU7L1VyaqaFyiub0dxIM
	zRMkvZBCGmMkaSyvFQsOOxUevUmbkVH+iBA+E1D3Jwd3300F1pYzhFy4jVTHSsp5a6w=
X-Gm-Gg: Acq92OHAColLCuTU8d4KAdTYHde0/S3O4VRJhWo4DSh+kO8sTVYRebu59NvmNmg6Eg7
	KnBZvb+yx+QWrPeyzsLISEUbiNhRHlqbYX2U91Z3VmshrPf7/1ZiwUj9yqkkWBXE2wASu08B7dd
	JM86o9UbtL8e+OkTNN0q5S4bX7ScwpMAu32TMKI5SqcFWgnokpMSZXZjcWbVsPXEb+vCpahMPoI
	fiTqkYxcyupENYplb656XKfeTbN90SYvEil+B2iC4lzwWSwek4i2szD4yHH1lQUFcNFkSHI4M78
	I1xzAVD5P3VvgCJApJaGV1M7bE02lXxvZ2/NZ4eah2vso1hhrBJlLSDqjolm2FaBxtZbKuV1zOF
	Vkk4tb+zNr7+RDuHUk+KhimARkDA0uO6FkLekPo9NTj+Xp95mTgoxdTcUOuIMfCMqnM3HWNZfDl
	jiovpcoxvv4SPyyIHWHk7Mvv9XEZIEVqq8G8OKXPck91DvNpdfxMbRi5iwnXV1svy/GL9TvwRq8
	dkpwyf2Xr09X7oBh8V7FcjihNNcs+rlmdX0lnhkiq0MeiXCQLVhf8V4qxOxRsyjNuOA8ODBUASD
	E7+WvkBIPXcFDdhextyPjv5yEmDs
X-Received: by 2002:a05:6402:501b:b0:687:50d3:d9e0 with SMTP id 4fb4d7f45d1cf-68836bca57emr1750276a12.20.1779373139016;
        Thu, 21 May 2026 07:18:59 -0700 (PDT)
Received: from ahossu.localdomain (ip-217-105-56-94.ip.prioritytelecom.net. [217.105.56.94])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6887e01f7b1sm225262a12.6.2026.05.21.07.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 07:18:58 -0700 (PDT)
From: Alexandru Hossu <hossu.alexandru@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	stable@vger.kernel.org,
	Alexandru Hossu <hossu.alexandru@gmail.com>
Subject: Re: [PATCH v6 0/7] staging: rtl8723bs: fix OOB reads and writes in IE/attribute parsing
Date: Thu, 21 May 2026 16:18:28 +0200
Message-ID: <20260521141828.784161-1-hossu.alexandru@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <2026052158-mumps-margarita-afcd@gregkh>
References: <20260521130330.754181-1-hossu.alexandru@gmail.com> <2026052158-mumps-margarita-afcd@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-253574-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hossualexandru@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A52655A7B38
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Greg,

Sorry about that :( was very tired when I sent these. Will add the full
version history for all previous versions and resend.

Thanks,
Alexandru

