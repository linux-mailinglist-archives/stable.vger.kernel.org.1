Return-Path: <stable+bounces-253457-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cN7UJ4yeDmq5AgYAu9opvQ
	(envelope-from <stable+bounces-253457-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 07:56:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B7359F43C
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 07:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3656E303F2AC
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 05:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB24B36E48C;
	Thu, 21 May 2026 05:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uyMlR4nR"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C1E367299
	for <stable@vger.kernel.org>; Thu, 21 May 2026 05:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779342960; cv=pass; b=DsYpQnWHxC8r69ekTrhJKrYYU+1V/4u7f8ABRMVEpd7J+KjLZrew+D0n2NI0TUQt6ZUiVyhQtR/bQqo7q6JlfJKAnvzeNch7H/PWJOfjWPIyMt0EBiv138HcMJj0iuLSrMrhBENESU34RNZYG6fi5IVe0vuwtOKhjKqb9u8p0Yc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779342960; c=relaxed/simple;
	bh=8RDd1Vkw6gxexCIfbv2e8CA2LxquhlAbyqCRXufRxrw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LZkf9FU6fVYPpLV2gGV4tibeyLGdY9UIVfIVQ8Uv58r3X4t7GXzTURI/Qx09ZGgMOZKcLAfUpXfrvc8U2QbxlBDLWwtjvB+thF6OB1FDbVGRKks15+RWpgLTr6irN3r6rnysFrTV0M1zPBz7gmqDbxryCcdMyC79pKjCaq+zcq8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uyMlR4nR; arc=pass smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-394095009beso50024781fa.3
        for <stable@vger.kernel.org>; Wed, 20 May 2026 22:55:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779342957; cv=none;
        d=google.com; s=arc-20240605;
        b=kn0zC6VTRuP5WI3roI8T2Re+L5pdNhqeOFag313EgyeWxEsK1FpZChX/CPeu9OiFm6
         i/ICwrobzSPPl7YpTiNWwsw59F4obOjs5RGqC4XYQg/JRA1mkTohGaNXwt0fNhyyhE1r
         zYg3HZ8e+J1Xl1HqMiQi8pRjVfFs0tpPVEn7Lv79BNUCo3Q+gC69LMng3W4o9Gv7tFoB
         2Cyescq6OFkst6yDQ5SZ1gVOQNGebn4Iq8mb7DXu8GnqQWx6kWBis8WDv/iR9Vw8BOKQ
         Lru1seoo0ifbZo+oansuEyfkqVRUWSpxPmwA0qEBfIaVGb1+GNnQVgbi8cH2Kh+C6/jc
         fHvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=8RDd1Vkw6gxexCIfbv2e8CA2LxquhlAbyqCRXufRxrw=;
        fh=NdZCa/uiFl7RAHMOogGlWF64h8ozkLBLAlr4AkxYWmI=;
        b=DGKnELHfOSwDanFI9SXeiOnW1aHJ9AQVUUCWYhpencVRQtVArNjDGrD4WLAAudTGUL
         Y9jMKh9jXGIlOms0QFEZadhqueSdnMa7RuUJQOla8i0a9zmfRDyHCGPRqeT63LgrVwLh
         mYpRer7h6LzKFYwCo5YFzEndcfJXhIrjL5ktiyUYCMF7FXj4ZIG9cH0bCM1EvmQm9xbE
         vTszDdpsICsDI5nzNyeImfuTNv+h+kIef8OkK5I0A8rcONn8gZY2JIncB5nbZx5YDFdA
         KlRTfrl+RTtLQqq8g2bh9PQ0YIzPa66RkZToNO5H2QMIYzjg0naFnAN1PgShsKU4mDTp
         w7aw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779342957; x=1779947757; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8RDd1Vkw6gxexCIfbv2e8CA2LxquhlAbyqCRXufRxrw=;
        b=uyMlR4nRN9UMNU7g9NZxZlcGcduMLeYpq1Wl+k9KAuWUlDZbrfWIfAa5yT5Esuo835
         w0dgvX2FUmPLuQBg1UtMXwwxLXQyrazbyW6MhZCM+kbE7eK2OwQw5jbBr9pz/0vxiJNX
         kbbGiEXQu0brwCDC2Mp6dpHz6/IEL0cGdOZSWM0E+dpOB2SuWRMq9X0ePu2W0ek0XYdt
         88A2pIzGDNYpY6gJGdoJonvtnl9zqd0t3nGRSwIwcEUaLicV4BRT2m2sLk7x75vq4sTq
         pVP3eD+ZAFJejXFGGHN7uJ0d7eGbHCuJrYI+vHU33uniBId0zgwmbLn93vVL+6bO1fkt
         zSvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779342957; x=1779947757;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8RDd1Vkw6gxexCIfbv2e8CA2LxquhlAbyqCRXufRxrw=;
        b=o1Iz/Y6dg38+BOVnHypAS0fIxB5XrNjTDFkOoYe0UdiPvtWZyMLL4HMUk2HlmHJH4n
         CiXKllC8SWPR5NHroXJwOOBtd+0UgoLAU7tTpvsSkcdlWppOVJnqoa8oFarkPN2Zp/Ux
         1iFkKR6ZllV3DHGdijsMnEni8gAazoNEpccInh39x7PDzNJtPDDnDEuCh12uH/kc3B7J
         9cMpcHciVkXmG/3JkCiULL8g/vLmPbk8wjX9zjxtwf5xJKQ3pVhj4wlb7+cu4QZoMrNc
         bCZMpsLDjcl/dmAO5j6klt71VRkWriDU9PYaIKBJxwegGbj/nZEOC6u0WFFz4etI6d7F
         3JbQ==
X-Forwarded-Encrypted: i=1; AFNElJ8F+9J/qFaZd5nAExyTeTUCXb41fgkrz7smRF7Ai6AJtxjlwydf06WqSDwMAACzo7M4HWlhAXs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYqXIs1nbdQsr4afqiY9R08PM6NG7PCwjRMpO4+54RTtdbm2DA
	AaMeZEeRN28BSX6ZQy4J9PGaS25C3rby3q2td+KLaih6uBz1jlS5gpvkgi4uQ/r0Ms4Uga2v96X
	Q2UrtXOpN7uBzf4Mn3TqsvqWYwX9u+EFlzpv0UTn3
X-Gm-Gg: Acq92OH/ZjotU1akdnidSO/vvclbrLVewL/yD/0lOR+ZnT3jNk+s463O8PjhN/z6KoD
	SyHRB1sRdc1+becrK1lwhirvQQQBcmYN4WQJgrRFxDkD79ztuje5Bc8bWWd0ZKWObZxRSaWEUD/
	t4SMALftuIO7CgDfPS7qYdcoTXMWRJyR6e11NI0d1um2rD0Moe/phYIXWiYPt53x1XacqaJzd43
	ho1WhCgDAe39AtuAiqeb5HRVSPBvKa+by0Cg/drG2yw7543dhPeDHoUrSp1feC0zylOItZ40xtf
	mcrM9bRki7/7W60pAz5J3I+G3Itk1fqCKYAhxSGzXfoawzQiWGU=
X-Received: by 2002:a05:6512:64ca:b0:5a8:f243:eea6 with SMTP id
 2adb3069b0e04-5aa2ba8c126mr327107e87.24.1779342957073; Wed, 20 May 2026
 22:55:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2026052009-vexingly-chokehold-f8f7@gregkh> <20260520172951.3087955-1-kpberry@google.com>
 <2026052015-prude-kelp-7338@gregkh>
In-Reply-To: <2026052015-prude-kelp-7338@gregkh>
From: Kevin Berry <kpberry@google.com>
Date: Wed, 20 May 2026 22:55:45 -0700
X-Gm-Features: AVHnY4IAUvN6IFg8uFDVKOUs0LPxNyjebOOchwYiewMTlkwmZtjxNoEZMp9LSnQ
Message-ID: <CAMAJAJHcuNPDraH+CcxB-TGGiKTuCJawfG4h0T6VrxizBm8SwA@mail.gmail.com>
Subject: Re: [PATCH] net: bonding: fix use-after-free in bond_xmit_broadcast()
To: Greg KH <gregkh@linuxfoundation.org>
Cc: bestswngs@gmail.com, chenglongtang@google.com, joneslee@google.com, 
	pabeni@redhat.com, rnj@google.com, sashal@kernel.org, stable@vger.kernel.org, 
	xmei5@asu.edu
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,google.com,redhat.com,kernel.org,vger.kernel.org,asu.edu];
	TAGGED_FROM(0.00)[bounces-253457-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kpberry@google.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 29B7359F43C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> What kernel tree(s) is this for?

It's for the 6.6 stable tree. I used 258cf62a6dfd as the base commit
(v6.6.137), but I checked this morning and it applied cleanly to
v6.6.140 as well.

Thanks,

Kevin

