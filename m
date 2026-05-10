Return-Path: <stable+bounces-245048-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 96AuMuK3AGqmLwEAu9opvQ
	(envelope-from <stable+bounces-245048-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 18:52:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 31664505388
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 18:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5371A30393AC
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 16:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B99D43AF646;
	Sun, 10 May 2026 16:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JaGaJsVR"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705B32727FD
	for <stable@vger.kernel.org>; Sun, 10 May 2026 16:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778431725; cv=none; b=RhKAAJ2rZArL3sXZER7S+lZEEuMF7I/es5BUDBqR+gBBKiI9KB/1i+HzZUC2Sy5nczkWVGM8We10kqNL+YV+ei7Ss/oHCHDSm5tDykZcZfey4i/uj8asnb5qiZJT46FCb896Jr2da83pj39P9uzpn1VMNfgFiMJkrLs5lWGjuas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778431725; c=relaxed/simple;
	bh=SaRV1teEcYuK3pDM4kjkaHnrIO71cSDF/PbaaMnoYTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pN5sJxTG2JtJZZOhPsqNs8eFE0//qIcnzA/wLjuMzrMVqXv/aHFQyd/hcKECyFFKpb/tqyTiL4xTF59WEmNYeOEmQDrlAc3hlERS1jGoy37/aOKwFgHE+TISC69GkpUZ1ZbMCmmWsRck93IOQjo+PTSJG9X6vgD1jszLlV6p59Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JaGaJsVR; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2b941cd869cso20546135ad.1
        for <stable@vger.kernel.org>; Sun, 10 May 2026 09:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778431724; x=1779036524; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eArBLCmYCsffvtaqVgZP4cXQn2AO6g/xQoo/oq6NlGs=;
        b=JaGaJsVRMIl2RcXQ5IAKLq1GFZwBXqvT93Ih88vKuq3hbLbu0apXjA4jhNUyEBj7rh
         mfyj4XvmgZ15Cr9LHVW06Lr+LGKhSVcCv8ALLB+rnQaaIO4SuQaqH53uJwn7i0nqYpr7
         b2lXFomRktDpMBgaCvAA4kP9CGW/Gnl1ZM6TvcRV7cI8d5LkQeiI8cMcXc/oZ6XjFqY2
         6stj+0Z+aTamVZPkbGrO74GedOFqWNgz0W+omL5VdjrDEHGG76XMjl2GbW3RkYgKciaj
         S/y0j2SQOlrwYcVujdTu+oWjAoh4jSAySswig+qH2spOkIlwq5QZ2ftics8kQIGMoe8P
         0iOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778431724; x=1779036524;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eArBLCmYCsffvtaqVgZP4cXQn2AO6g/xQoo/oq6NlGs=;
        b=sgfznWlRyqxhp5otiyKrRQZF+jgy3yp5d8KabIFxm8XTjjLqA/1dRDum4dMFhPz2cM
         Z2pky6tIxmKOQdsoYefkJeUy+E+XcwrB9ydelOttBsBUlW/U+JOZpppBAnm6/CoxUDUR
         1L3Uhk6ajt37ljmpO9pUg6UBo+yaSvSp5e/vo7aA57FT8E8H2SxbUc7hkUr2LyyNcsHU
         dg55VdagZpd0xQXUStZaHhyU7hQn27BAOF9V977ChX6UzAV4SzITteXv75IHjTX/kBR6
         uHFP351iNaAh6mMQw32p74vUuXmrXBS8ZPsm1M6mDszbwC/hw15t40JTqPHthfiUxuui
         LM0g==
X-Forwarded-Encrypted: i=1; AFNElJ9moSoGDE83k51CxllTpYdZH/gB423ADTU5l+yHpjhxc3mOV+qE4GIDL/UUPjnmnAUd15D/9z8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFKgJwSX96lSGq1flK6gp99ZXusHGEEFWNRAtv1ixy06ays2Yi
	apF/LOpzdrMn41ulzwxTKC1guKqZ/YWJJsPd18wbcwgaoM9YVUXXZXeA
X-Gm-Gg: Acq92OHQl7i1b3OaCaA8amZT4XVywvZ0R0kMN7ND0OP7Ii2WQvrTMgOntU85ENJIaDV
	3ufE3DwLtIunrlK4IyEvu0tnfLSjFXjzixxFL/Gn/EZB6MsuOmnc2lja7tfvGVF9U/ZNG5htip/
	o4UdQx2Np3Ej25iIVfm1IbgD2FOXSikCGBKTFrZNohSIWZc2V62XNRu0f0ZUQo3PVa73fkM9kNg
	C8h9+9NEsebMroo/bybHCb4N70ftgsb4WS9jUgQZeea6sqCVCn5N2ZzzEUjXdav/ZOAcBwIEiFM
	M/Qo/CjMQuM9F+nRwks/nFo75tcL8TMLNwQxCWHCKromb8Az97JIRl9C0XI1rZtraw0Yhcvrvob
	oRYzUnV+Q2Vjmjeg7pWZ9o8ewoFDInMmZOA8VfpnMKO0vKKXj7P/ZXCEt9L3eIs6Acg413BQzop
	xuj97TiJqpE5hNgAKnt9aXnjmz+3U2a5YAKl5YX62U6fCxSpQySYg5ZA==
X-Received: by 2002:a17:903:9ce:b0:2ba:b5a3:1864 with SMTP id d9443c01a7336-2bab5a3210bmr186878225ad.20.1778431723638;
        Sun, 10 May 2026 09:48:43 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1eac3afsm83382135ad.71.2026.05.10.09.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 09:48:43 -0700 (PDT)
Date: Mon, 11 May 2026 01:48:39 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: dhowells@redhat.com, marc.dionne@auristor.com, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
	qingfang.deng@linux.dev, jiayuan.chen@linux.dev,
	linux-afs@lists.infradead.org, netdev@vger.kernel.org,
	stable@vger.kernel.org, imv4bel@gmail.com
Subject: Re: [PATCH net v3] rxrpc: Also unshare DATA/RESPONSE packets when
 paged frags are present
Message-ID: <agC256wVYa4Gnvy1@v4bel>
References: <af2kdW2F1gJ9U-Gg@v4bel>
 <20260510084520.476745b5@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260510084520.476745b5@kernel.org>
X-Rspamd-Queue-Id: 31664505388
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245048-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[redhat.com,auristor.com,davemloft.net,google.com,kernel.org,linux.dev,lists.infradead.org,vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[imv4bel@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Sun, May 10, 2026 at 08:45:20AM -0700, Jakub Kicinski wrote:
> On Fri, 8 May 2026 17:53:09 +0900 Hyunwoo Kim wrote:
> >  			    sp->hdr.securityIndex != 0 &&
> > -			    skb_cloned(skb)) {
> > +			    (skb_cloned(skb) ||
> > +			     skb_has_frag_list(skb) ||
> > +			     skb_has_shared_frag(skb))) {
> 
> We seem to be getting a lot of fixes for this issue, and this one is
> incorrect :| Writing to _any_ frags is incorrect. You have to copy
> if skb is not linear. skb_ensure_writable()

I was testing a patch based on skb_ensure_writable() but it seems v3
has just been merged to mainline...

What would be the best way to proceed?


Best regards,
Hyunwoo Kim

