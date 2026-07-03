Return-Path: <stable+bounces-271828-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +aU2LG3hR2oVhAAAu9opvQ
	(envelope-from <stable+bounces-271828-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 18:21:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A2070434C
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 18:21:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=smile.fr header.s=google header.b=oWidXmLO;
	dmarc=pass (policy=reject) header.from=smile.fr;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271828-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-271828-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D1F3730135F7
	for <lists+stable@lfdr.de>; Fri,  3 Jul 2026 16:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 276F02F7F07;
	Fri,  3 Jul 2026 16:20:34 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A2E2C11FE
	for <stable@vger.kernel.org>; Fri,  3 Jul 2026 16:20:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783095633; cv=none; b=gUTQ+i0wHJNeME97p/cdCBviQRQvpoo7OUmociED5dyUXHOSmqyJH4clrWRdyeF4+tGH74K+Tgn7S7/PNd7ZqQYydJVsQuo3n08cZoMqSjdAkWKIHVATiRpNIYn7Dfpl/iwqD+UFjXvTprxCmdzHv9R9sZJf4FgaAH4QopV21Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783095633; c=relaxed/simple;
	bh=sIKLbGGOwpaMAgJY+13YJB+xbBvJbDLH3pHeLnHQX3Q=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:Cc:To:
	 References:In-Reply-To; b=bo8W/nj1sU676LnnhU04Den4EjMA1cHBE9b8GRoKVfFM00nfKm7KGWZGd0lmsVSN3qtH5jHksrokO4dBhx2nPYGpzg6ag7nxwpdFIayxcdbUTlD4oAnDe7IJqgrgn9F0+CZ47Yg3vdGM5VUs+Eosbp5qtzPYFe4EVhG1Zfwb5JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr; spf=pass smtp.mailfrom=smile.fr; dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b=oWidXmLO; arc=none smtp.client-ip=209.85.128.54
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-493b61b52b6so4758765e9.1
        for <stable@vger.kernel.org>; Fri, 03 Jul 2026 09:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1783095629; x=1783700429; darn=vger.kernel.org;
        h=in-reply-to:references:to:cc:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=sIKLbGGOwpaMAgJY+13YJB+xbBvJbDLH3pHeLnHQX3Q=;
        b=oWidXmLOCCGmafw7NC1MQsDbbYO9eJXJtRjT0PK6uDK3G9/JPM46FZf188F9DKhvnG
         H3vmq5+xV7fm2m8xhPRcMkoAv+mSkMdLZIpaZPjOx0BgDRpFH0I8+1iy6WB6zs7U145p
         ZwQETQCeUmL6IdpDQnTWSTI3vGJ3Q+X42zsyA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783095629; x=1783700429;
        h=in-reply-to:references:to:cc:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sIKLbGGOwpaMAgJY+13YJB+xbBvJbDLH3pHeLnHQX3Q=;
        b=SYAoZ2pyf63jcQWwM+nIR80XERXty4c1BXVJK7WZAfnCMUpZlBmlqFd6NTbfAeixJk
         fCAUATLfkLrSKWnrv+SowKI8QgLt/rAPbl+1I+DRFp1o99KFlyQcqZ0cFqOhbBj76bSj
         aWUI793eXFjZOx6l4w4+bjKwqVuRe9+T3gV7/8pciAse0iKA2rTOidY5ZUsfD/vX/ZKt
         PBPmr5iCFYiuQ3XATGZwMgfzh64ckHGCRG7AQ18IXz61U0kFX+JldLuBq6032Jb80Er9
         Kxns3r9Bn48hCooUIVrskFru5jxzA0DW4nR3gSIV7vwV8PeoeptEVjt3Pn/t1aY6QIgN
         MiOA==
X-Forwarded-Encrypted: i=1; AFNElJ+6OhxQb3354ZdcazIhuLbTpU+Nq/wnHadAdWKCrk1vRR7dfQsaCIe2xJafIdPC28CeUy8bwPs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyVfYTV6a1Syflts3mUzfY3FGDAdbvrxxQAQWuoKMqNa83VE6R
	f9At1htctQMaLHlw7xHaD9PTu55tgzBa+7esxahypjrOewsby8hOMR+VcGaQK3q7LQ4=
X-Gm-Gg: AfdE7cncymUKGfQanguRqu3mQ7sjHoCmBZSM9Hn0OQf8GcW3M91cNxb4ALIqBI2o+Kw
	L0DWmVScnr3M+Z3uumudToGWUbQGCztWZ4DReLglECfxf4jZB6mgd3VIlJlJkudGT27n9xjdjrG
	kHsTNCeQEAlw3pSsUlGA2854xJSz2QDqDzrkFq9faBX1eFudUEedqspboxJwjMzXkrk+yqSahMb
	ka1gUiqwTDUDXdV+Yfe8wzh2T0WWD/cw74TfvH+YFBJVjkkaUCHtkEo3bomrOuNziUwxyyVgyKa
	iF7PK5jwtLMbET2ajNraXgV3eFT4yy9Ecird5YwfJKHyneKiB8qL951mW/dErUaEwyp/FxHphFQ
	w6+wisXHa7O8qlgU5s6QzKksrfoDWT4EfTM8EH8m1dtE6GN7vtxOqbTKZSu9vZhSzs0JeatgA+t
	mXjAPLiXnO8vkbuSW0TZPP1YxwTQjWx7ZTp2Xum/AJrR3nQ4q71qZHywa1Wzlx4zUNag0Rr+1De
	u2nFA==
X-Received: by 2002:a7b:c357:0:b0:493:a570:df7d with SMTP id 5b1f17b1804b1-493d0f335b3mr4211505e9.20.1783095628723;
        Fri, 03 Jul 2026 09:20:28 -0700 (PDT)
Received: from localhost (2a01cb001331aa0075403fb2c9c4e210.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:7540:3fb2:c9c4:e210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493cce0a7cfsm60003245e9.9.2026.07.03.09.20.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jul 2026 09:20:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 03 Jul 2026 18:20:27 +0200
Message-Id: <DJP2NAVND6C3.34I2E0R3EDJPD@smile.fr>
Subject: Re: [PATCH 6.6.y] ext4: get rid of ppath in get_ext_path()
From: "Yoann Congal" <yoann.congal@smile.fr>
Cc: <linux-ext4@vger.kernel.org>, "Andreas Dilger"
 <adilger.kernel@dilger.ca>, "Theodore Ts'o" <tytso@mit.edu>, "Baokun Li"
 <libaokun1@huawei.com>, "Jan Kara" <jack@suse.cz>, "Ojaswin Mujoo"
 <ojaswin@linux.ibm.com>
To: "Yoann Congal" <yoann.congal@smile.fr>, <stable@vger.kernel.org>
X-Mailer: aerc 0.20.0
References: <20260702154810.3435236-1-yoann.congal@smile.fr>
In-Reply-To: <20260702154810.3435236-1-yoann.congal@smile.fr>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[smile.fr,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[smile.fr:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271828-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-ext4@vger.kernel.org,m:adilger.kernel@dilger.ca,m:tytso@mit.edu,m:libaokun1@huawei.com,m:jack@suse.cz,m:ojaswin@linux.ibm.com,m:yoann.congal@smile.fr,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER(0.00)[yoann.congal@smile.fr,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[smile.fr:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yoann.congal@smile.fr,stable@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,suse.cz:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,huawei.com:email,msgid.link:url,smile.fr:from_mime,smile.fr:email,smile.fr:mid,smile.fr:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A1A2070434C

On Thu Jul 2, 2026 at 5:48 PM CEST, Yoann Congal wrote:
> From: Baokun Li <libaokun1@huawei.com>
>
> [ Upstream commit 6b854d552711aa33f59eda334e6d94a00d8825bb ]
>
> The use of path and ppath is now very confusing, so to make the code more
> readable, pass path between functions uniformly, and get rid of ppath.
>
> After getting rid of ppath in get_ext_path(), its caller may pass an erro=
r
> pointer to ext4_free_ext_path(), so it needs to teach ext4_free_ext_path(=
)
> and ext4_ext_drop_refs() to skip the error pointer. No functional changes=
.
>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> Reviewed-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> Tested-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> Link: https://patch.msgid.link/20240822023545.1994557-13-libaokun@huaweic=
loud.com
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
>
> Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
> ---

Hello,

I missed it at first but a discussion about the same issue is happening
here:
https://lore.kernel.org/all/tencent_C982B0201FE8F041BD5B4FC1ED7D646A740A@qq=
.com/
But the above is a partial backport whereas mine is the full backport.

Regards,
--=20
Yoann Congal
Smile ECS


