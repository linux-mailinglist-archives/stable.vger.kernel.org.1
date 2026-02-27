Return-Path: <stable+bounces-219961-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uEVgH0OdoWl8ugQAu9opvQ
	(envelope-from <stable+bounces-219961-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 14:33:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A481B7BB0
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 14:33:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D7F6F318DC50
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 13:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F067925B663;
	Fri, 27 Feb 2026 13:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="VZspAtsA"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8979C248F68
	for <stable@vger.kernel.org>; Fri, 27 Feb 2026 13:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772198990; cv=pass; b=GHN7asoLEMA9lYw5RIN+XzxqjGjEhiT5/to7KsUglee6rF/30svWXLD//BJ6X5GE9zaC4PDqM3ANFjmWOAwBfPCNRMCntLNBdtT4Iu70/vz479Rp09ZnRDiyJPbEtB0D04ee1IA7qWWU63JWuOUVGHZLMfBlx3+2dwnOyOAwgR4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772198990; c=relaxed/simple;
	bh=iGKebz7R0c4Rq9PoP0LqbuUmiYNHkJn56cg7vDblbXA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TRhK+0TIk4kFo0LDcKDQHy3v4+N5+lFUHXUU0z5gQBfa+vCg4UrxbLPC7Y4mIGxf8N2eq0vK49gpWG+TmGvkdw+UGF6+bmkIQOdBnlOTcQHV0rHYXCWiWn90L6DyQtFemjWDoGAmXSoCU/0EseMuMcvradD8ZiFevhicBQbFDIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=VZspAtsA; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-64c9fcc24b3so1454702d50.1
        for <stable@vger.kernel.org>; Fri, 27 Feb 2026 05:29:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772198988; cv=none;
        d=google.com; s=arc-20240605;
        b=YIFtrx2l6hzq1Q09bOzUPGxzBc6vDut1pAfHAGI15yheJXmXXNPbO9+3c3CUaki+2b
         9CsDV7KrG4STCqI7YLDh67nKDw+dZLHDGoxvCHHeoClaG7q3qtce65fVB8aRYAs64To4
         tXsEwuNytf/k4i8ZDcVXNIJrQ1xYnYu12Mz8bwzJ1uEbIzgJbHDuxHVTFthVTabX5K9F
         UXlxIQT7o0yusaYo2kVhaJ0BFq7oSBcecc+GgmoL6/1eVnzGeChL0hAkV8prOzN3AfBw
         L6ekszr2uwqVUc7wAhZuqPbcaQhxOLIuctG9JdGqFZaK7rW5KYdRjZzgThPeKTCxM1k8
         ulgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=iGKebz7R0c4Rq9PoP0LqbuUmiYNHkJn56cg7vDblbXA=;
        fh=F3z5riCB3aWU1SAfknEAjwpPCptmP5puMxa5GNej/5Y=;
        b=Nhy8PHg+4r880Nq6Hqp84iLgEGRzWjP4oRKcPQ9AOTJrYQq76hR+tp2p8Wd1s/EVLy
         9eB85kJ+RUSHtCxfys4vA0r5EjRx4V6xseLyR1FQDCFITlTrv28ylUd6S79Or977Tyyv
         ZVYdUdY5eYqousXeap15u6PVuHUWsmmclU63BpvrFQzTDXOPpIbm9NOR3ftztHXQTwef
         hCr1EAstFLoM8h9dMnFJADFd7YTogb7dw4OnXhU2Pzcra2hoLc4t+07r5xpOpYi2QdrZ
         tKXEeiEewwIAksprvo1n+/JeyNzOx8FcfSepOgtMOz0sMTOoSPlsbV1OsTXuVTmqe/sY
         dkug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1772198988; x=1772803788; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iGKebz7R0c4Rq9PoP0LqbuUmiYNHkJn56cg7vDblbXA=;
        b=VZspAtsATpWTq7m7o+s0r7RcPuJaMhq5luBViWdeOE04wPKCXB+Cn9aejtaEcN2wdZ
         iNPvyqguRbR5kL7GxLkzOt3g9NXACLzfMkyGKSm1vP1YR+UdzLA8GPWOUxaZQrmSafAc
         XGq/Vw0AS4DKRe11eN6oJD2euN6auIDBtdG3lqh4BJ+w7V8dxxXzZ6S8TR1RI/60OU8O
         GFHAcToSNidQAA4RKbACdZGHg/upwKNwEUhO8i8+WRXG4Xni5p41ypaNHTLcXExAHXlm
         lP7g1UL/ijTvbj82GLHfaRFC5COub+gRaNfbEJ5vCG9n+MkrLnqBPrkdw2+FxpX8Umqh
         itYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772198988; x=1772803788;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iGKebz7R0c4Rq9PoP0LqbuUmiYNHkJn56cg7vDblbXA=;
        b=TLDmHrhpY/Ky+biLXpNxbR/BJGwpIGTsDROz6bIEeOoeLokzsDQfiesGwYmcdGB4x7
         SSaK+SnbHJI1lw8qXK9ygDb2wWjqfg7Z6o88NBYAon0zo8AZs/kgFXCcD7Nmz5EvNuar
         6JN1OCODc9FAJQwLf6MrKfNbkzDjq+Hj6G2pxJYXeIU2ONkexh7Wi0De0tFt7rJRA39l
         9K14XkVsZx/r2/Gduk74i8whDO6q6KBMYq9dUrJhYwaRuNN9WY/KxfzmJ1IFrYF+A9M/
         OYQ46J/92G6o04szdT0YdVxMZ8SUBkFmtwnSv0NKK1v10O4Cnzb4z+x4Cgghq/OF6uDR
         Dt4A==
X-Forwarded-Encrypted: i=1; AJvYcCXxo6cwpVmxJlKn5W8WcHI2g24VjMC3dOsU8uoMXNVxUGmADjNSJVFECzbbwYLlTWve8kvLU9k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8jRCNu7cmxkhgWKVfNVaWZuxYBp1d5nmgETFILOOP0dFIfIBY
	i7LKBwsxv7MS33n0CA8n7GGuWrBMnlcB+XHk9uEKJ8TFPKs7dYg37vZndHE4ljpvBpeZFi/8XMt
	xQYrIreu0Y0lRMv/c3iK+oatf7Vb/2OlLKal3pHiw
X-Gm-Gg: ATEYQzw0hABCkS7ujA2raB0oneDj5nI7olOKOjoctkX4Qg2iQzHTHYM+gkKG+Fpfr4M
	W3ZTr1hE+URaKSES0q9U0rUw3PVMNLsFEtWH6jr+hdOPuF+tFfnfwT0X22C4Czu6Y47ZTFKtMln
	ExIWRdOTuS/vzzjhlF2W+WPkp/AullbN7Cd1Rb9Pcl8t8sCRQNiVlnE9EYLTbQi3K52WINnggDL
	3AfkYYDJKnY2YwwQPmTvXZpGTRRsu0RNUWuqkZvD+WJH2P7hxYgDp13fb3Mbqj4gI6zuCpI9BrQ
	5HBhYvXucDJcbfHqySqDVPUtRCyk7iiW
X-Received: by 2002:a05:690e:2060:b0:64c:a1b9:ff8e with SMTP id
 956f58d0204a3-64cc2025a17mr1867109d50.15.1772198988446; Fri, 27 Feb 2026
 05:29:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223150512.2251594-1-p@1g4.org> <20260223150512.2251594-2-p@1g4.org>
In-Reply-To: <20260223150512.2251594-2-p@1g4.org>
From: Victor Nogueira <victor@mojatatu.com>
Date: Fri, 27 Feb 2026 10:29:37 -0300
X-Gm-Features: AaiRm532xdPQGIE3xPApIpgRqEq3CFinlPLHTSQm8jaoRnx_ggMxrqHvO3ahzPo
Message-ID: <CA+NMeC-PZGQo1JCPj60Ah=Oh9ZSDv-ZD5JSH0nD3+H_LVuZqpQ@mail.gmail.com>
Subject: Re: [PATCH net v8 1/1] net/sched: act_gate: snapshot parameters with
 RCU on replace
To: Paul Moses <p@1g4.org>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-219961-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	URIBL_MULTI_FAIL(0.00)[mojatatu.com:server fail,mail.gmail.com:server fail,mojatatu-com.20230601.gappssmtp.com:server fail,1g4.org:server fail,sea.lore.kernel.org:server fail];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[victor@mojatatu.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[mojatatu.com,gmail.com,resnulli.us,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[1g4.org:email,mail.gmail.com:mid,mojatatu.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D5A481B7BB0
X-Rspamd-Action: no action

> The gate action can be replaced while the hrtimer callback or dump path is
> walking the schedule list.
>
> Convert the parameters to an RCU-protected snapshot and swap updates under
> tcf_lock, freeing the previous snapshot via call_rcu(). When REPLACE omits
> the entry list, preserve the existing schedule so the effective state is
> unchanged.
>
> Fixes: a51c328df310 ("net: qos: introduce a gate control flow action")
> Cc: stable@vger.kernel.org
> Signed-off-by: Paul Moses <p@1g4.org>

Reviewed-by: Victor Nogueira <victor@mojatatu.com>

