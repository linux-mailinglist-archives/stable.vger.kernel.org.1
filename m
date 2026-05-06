Return-Path: <stable+bounces-244446-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wCslF5+k+2mvegMAu9opvQ
	(envelope-from <stable+bounces-244446-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 22:29:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C124E02FA
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 22:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DBF273009517
	for <lists+stable@lfdr.de>; Wed,  6 May 2026 20:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EFCA37C915;
	Wed,  6 May 2026 20:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PqAIKiP+"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D531837C0FD
	for <stable@vger.kernel.org>; Wed,  6 May 2026 20:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778099327; cv=none; b=PC+JuHnnFzyrb2fXtjuy7CIIJWG+binc3sc37mZy/Z313bGDrZjWa2aRxSAsG2s4zuKZW9HD58f/Ew9EkKHBrm+7xa1nwq320QpFPhJAV2WawGca7QJQkwFEdB5dU8wLB2vsDzYbHMgUtCaV0gjHJJrHFqYRERjQ7nmr9RR+Bus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778099327; c=relaxed/simple;
	bh=OCml1MDftHSrv04eLcuC/2uo7tp8E+2t/w3q/S4/+vw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gKRj6Z0DKLuqN64tW9bmND6kH2eqhns0lc52rz4V6mXOQny5/6heXxd6kG4NKZ9ahXQz8nSV9kxRd5ivCblTNTiB6MT9dOKEmHLB1/eD+uGtvSyiUjFkkCIqmEHHPBMcYpGgeVDhhkzZh2CsAOP0LwBoQpml4eyOof7HqsZQacs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kpberry.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PqAIKiP+; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kpberry.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c709551ec08so117659a12.3
        for <stable@vger.kernel.org>; Wed, 06 May 2026 13:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778099323; x=1778704123; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OCml1MDftHSrv04eLcuC/2uo7tp8E+2t/w3q/S4/+vw=;
        b=PqAIKiP+tznnaVLgFqmo3khbRa464dCWCvv8OgVAknmxmD/kUStN+w6LjK4bmRrSdG
         vapMBXf2yklQgPrUnKpSxqQilx1hJeYz9hcDSEgl9zOVtRtgx7yAxp0VZOo+4lLE6h/9
         nsWoQ7kKSlLVVQizcBVQFnrd6Y7WMREXlVoVikaJHPxcAwdoROzq434oLUKdnZOGJTJu
         F2R8OioK+8rT4bGERaIq9DUI8nYFh6MSbBqmnRmQSpWsoSm1pkUqa4kvtdluYSJITqE+
         XVRyxUEQb/+cXoxK0H3w5pmkUDs9OWotK8OWlgptZRFl91jCjM5YQSQNJcc9ttcbkcOs
         2MHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778099323; x=1778704123;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OCml1MDftHSrv04eLcuC/2uo7tp8E+2t/w3q/S4/+vw=;
        b=DX/Y5aFsBtqqkXBPcxXa4PzY7w6IINzj6bgMrd4DGymO21hmdbqaJGGU5e1e9+Gvcq
         af9uozZBTv13yeMq2ZEh5AZ2idt+hXAaww/l+dtUD//xEukWuB2Aqs4KXyEoVPCZ7fXl
         mw8nei3QRotQs4w//fywt+h7u+rrTihlJJ1hwYEpVV0DrKuIgicxvM5qCUlryXjpPTNY
         TW3sSofG3yyFy/iNbnhtqhSa6QRu6GlmeDlmME7V3wCtw9PkTLY0wpLsRh0wrmOvBqdk
         +pIzY82XygPvoZuSLcNmwJhLs0Zds0sB1CqlJ1zC86pYm0GWVS26XIVFz8tJqlhqpJqL
         Nrag==
X-Forwarded-Encrypted: i=1; AFNElJ8hu+AUE9c7CxpvNg7+CDW1c9i1lt1sF0F2RINSNX93lSyUyBkm2j0I60cSW5m9fkoiaIlmZO0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUq3IUYUAmAEuHehzpKrObHHvVci16BBc5i9MQ8/DoAfpDvvPE
	gm0n4KrIwJXdpc8erbqinsgb7peoI2UZ8p07DNPKONC+GvU1pcGLamgJ85YpqTqUtOP3nI500oK
	aqpYLZY721A==
X-Received: from pgbda3.prod.google.com ([2002:a05:6a02:2383:b0:c73:bc95:cca8])
 (user=kpberry job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7f97:b0:398:8f2a:5dd4
 with SMTP id adf61e73a8af0-3aa5a8319d1mr5619276637.8.1778099323346; Wed, 06
 May 2026 13:28:43 -0700 (PDT)
Date: Wed,  6 May 2026 20:28:41 +0000
In-Reply-To: <CAPpSM+TbMOPL93CkWtrYjYW+T+Q+iWuo+ZhfutYNFOuOCBU5fQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAPpSM+TbMOPL93CkWtrYjYW+T+Q+iWuo+ZhfutYNFOuOCBU5fQ@mail.gmail.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260506202842.1788682-1-kpberry@google.com>
Subject: Re: [PATCH v2] net: bonding: fix use-after-free in bond_xmit_broadcast()
From: Kevin Berry <kpberry@google.com>
To: xmei5@asu.edu
Cc: bestswngs@gmail.com, chenglongtang@google.com, joneslee@google.com, 
	kpberry@google.com, pabeni@redhat.com, rnj@google.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: B1C124E02FA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,google.com,redhat.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244446-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kpberry@google.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Hi all,

Sending the patch for 6.6 as well since it should be the same as
the 6.12 patch. Tested by compiling.

Thanks,

Kevin

