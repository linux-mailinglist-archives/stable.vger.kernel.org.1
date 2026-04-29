Return-Path: <stable+bounces-241946-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Hf2Au9y8mnjrQEAu9opvQ
	(envelope-from <stable+bounces-241946-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 23:06:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9997F49A659
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 23:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8DCEF30342B2
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 21:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 418213939AE;
	Wed, 29 Apr 2026 21:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MVLDABHH"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB0D37648D
	for <stable@vger.kernel.org>; Wed, 29 Apr 2026 21:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777496630; cv=none; b=LjiQ5r0MiRFIGrgDQNCB3OjNW97HBi9j8nyLwdDxNk6TFmwpoB9G2rbRkNkQoM6T104E6jlpeIwbByuV5ykoSsvGhS6oJkFPPMPb6IsMKK4eE2dKG9dw8LHyoqHk/BIaDvpCYAvuPv/W23eyHLHRDSsNv9jm/PNuX8FpEXyJtDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777496630; c=relaxed/simple;
	bh=2aA3uWTswagHEVLFA8v5skfAX/JT54EYEV9OQ+OofHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Pnt6MLVfD2vMz3LpusH8QxHABv1j+5084Q0PuIpZrkD4H/XVzo2T0dKPMgP+5JockAebQ25hpf9xY1aLAGKo0oxN0yUOWPLOStDQALLpoUlwzBHf61sFwZRzjaq3xRAQY0vi0nj/DIsEpauGCb2JSgVIuLNnELfPM+jnxYTctnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MVLDABHH; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-488ff90d6c7so1636125e9.2
        for <stable@vger.kernel.org>; Wed, 29 Apr 2026 14:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777496627; x=1778101427; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9eaYTnlxpHCY09/j5CrSkFztBrg3e6wlR9rFliILkCQ=;
        b=MVLDABHH2s+wca68H4L+y5daBBNCnTUMhWl6HRklW6MSdEAY4a6yOrY5kF9H2KYkxy
         nMNeIbT2Bp9W649poDIzsnnBlgtFphG1BsOmUM7RBiqNYf9eo7Z6bYShIjfKQgNufM2J
         1Tg61FURYlgeIfbFgNo8oKo1nzyRdmOqwVd2Ipzp4KKbZUVS+vR9elLc79ExJ/79Ijp2
         YDyL72gafLeamh7GrT0yuUYsnCdFACHI2ENscvafXVJsfrbQitd3Xgq5bME2LnQ1yAoh
         ob1NstAwBzNdtWtfzA09d5ECVRx+U5gXGcbSukpebnoPW1y8rFHisrwQ2v+LDiJ6g25D
         sqbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777496627; x=1778101427;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9eaYTnlxpHCY09/j5CrSkFztBrg3e6wlR9rFliILkCQ=;
        b=QkvWZP/OU6kjMmIGh9W8O+L1qje+L1+A9eTEPKFChYz+Hd/ALQK93uetPgbS7WrJ3G
         +Mp1kFsAUTUXBpcJTZv/YMm5QIyq/DQLfTB9kZsE5QZYMQl7wCXwYSvZJmpCLB1e/tzA
         JOGQKGTwqDRXnk7QypaQsm1SHzUdqONaeQVUPEuLzb1CVulXL7wx90CHu1BoiaRy+h6t
         QJZ0+y52ixYCHtO/VqOvjxnchqtLPmIFszxOR23PHrILmZfy7QT+A9XxDSWejNFsaXPe
         yTeZrJuQ8yBDd/pfmd2SEoH0mXXjorvHXYFnI9WxWMlxwLgNMmNCSYNEerfUk2AT00e/
         goCA==
X-Forwarded-Encrypted: i=1; AFNElJ9Wn/+q0HWORPAD+f3OAEpNLQlLRr74E2zisEujenrl/CYZje881L9e+wvX4RdlfgJypgiC0nw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx9H6glSvDuk9jsGpR4+Pox3X3oVKPmqbmT3Bt+4L7nfXNdVW7
	W/75EZnEJJu3Z1D8rq5SF0XHEecuyxP7T32FcLC5+tA65CKqHVj1aZQ=
X-Gm-Gg: AeBDiet7nL8im4IototiLi8+f9jgzhURNtqGsJTQacvi6l3fesykFXsFf7wGjtvpMuV
	YgqkNAPfFpnTp/KrNQnGLTIE+GsyD4JHNAuXvPRHvOHD1v9o3cyk/gqJ6BSQ4p6+UMAKQk9zu1O
	cZNAezaTsOoCoGMwkxkowU5J/CFz6KQ02B4u/zP+85/FU0rbX9Qfcp8HEmxECgqX9p9PLahSvnP
	c+WEeO9HKQgQO4OY7tNegKq1XbMOm77qsDZzaiomAyCLKUwYeEHJoFP8JfIuorOrS4B8GNtwk8c
	1/itul5x6daLNfwYR2mJGhPaCpf7H1BwfwclePKn3Vbrd0KeOU8hxtqPvKmrOXEeGfw7F8uMGSs
	mMKWcYqKdq7KUxbfi9nbMaVf7VLc7uCdyTxMcQo1xEyxdNW6K+lI1M/ZuwgLubT+zQ8f5WgCMyn
	yieWUSpza9riNflg==
X-Received: by 2002:a05:600c:350d:b0:48a:57e1:d8cc with SMTP id 5b1f17b1804b1-48a83e7055bmr3924695e9.9.1777496627067;
        Wed, 29 Apr 2026 14:03:47 -0700 (PDT)
Received: from debian ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a822c832fsm29134635e9.10.2026.04.29.14.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 14:03:45 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
X-Google-Original-From: Tristan Madani <tristan@talencesecurity.com>
To: Phil Sutter <phil@nwl.cc>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>,
 netfilter-devel@vger.kernel.org, netdev@vger.kernel.org,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] netfilter: fix NULL ops race in iptable lazy init
Date: Wed, 29 Apr 2026 21:03:44 -0000
Message-ID: <177749662469.1430165.8044688741351868980@talencesecurity.com>
In-Reply-To: <20260429175613.1459342-1-tristmd@gmail.com>
References: <20260429175613.1459342-1-tristmd@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 9997F49A659
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-241946-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[talencesecurity.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Wed, 30 Apr 2026 Phil Sutter wrote:
> Is this true? Your patch moves the ops allocation, but new_table->ops is
> still assigned after xt_register_table() has returned. AIUI, the race
> window is just reduced, not eliminated.

You are right -- I missed that new_table->ops is assigned after
xt_register_table() returns. The table becomes visible via list_add()
inside xt_register_table(), but the ops pointer is still NULL at that
point. Moving the allocation alone does not close the window.

We cannot assign ops before xt_register_table() because we need the
returned new_table pointer to set ops[i].priv.

Would a V2 that guards the pre_exit path instead be acceptable?
Something like:

  void ipt_unregister_table_pre_exit(struct net *net, const char *name)
  {
  	struct xt_table *table = xt_find_table(net, NFPROTO_IPV4, name);

  	if (table && table->ops)
  		nf_unregister_net_hooks(net, table->ops,
  				        hweight32(table->valid_hooks));
  }

This way cleanup_net simply skips the table if ops has not been assigned
yet. The register path will either complete and call
nf_register_net_hooks() normally, or fail and clean up via
__ipt_unregister_table().

Thanks,
Tristan

