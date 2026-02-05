Return-Path: <stable+bounces-214458-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YD3dG4SahGmh3gMAu9opvQ
	(envelope-from <stable+bounces-214458-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 14:26:28 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA1CF33AC
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 14:26:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4680F3024970
	for <lists+stable@lfdr.de>; Thu,  5 Feb 2026 13:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08FE83A0B0C;
	Thu,  5 Feb 2026 13:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="qw3DsE13"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789C83AEF25
	for <stable@vger.kernel.org>; Thu,  5 Feb 2026 13:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770297869; cv=pass; b=QpEkLu16+MobgA/1e39oXOFET4WsRbSpaOGg9vaTe55O8+YPV48zHe5TVVtH3baqaB2Q8h40ZVjkApEudMqBtQa4YMMeRsg/qXOKrdZWGAGnS26rAgN7bWX8urbl1GvQCHK5o0YcrdUxtj8O/xq1XhqrpHMrMS5McGmS8dHphqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770297869; c=relaxed/simple;
	bh=PQuFRfseGtjZCs2LnFMBc+gFccaReHz9yiCewWdr7tU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BWaUvPEMZUxVwYVBzwmhJxH9RIzT10xlEmJ5cYN3bE2h5MkzX+ezEZcdl+6kuPGl7SeMGFBZoIxvV2Ak1cqkxaKVPPLIbAlSu2jSmwc03h9uESEZpoXrW/gDtaWg6CKIpl31/J5pCq/qmMoOvHp84cZOhbivsIXmkwUC1SU4B94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=qw3DsE13; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-649db2b6cdcso1049655d50.0
        for <stable@vger.kernel.org>; Thu, 05 Feb 2026 05:24:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770297868; cv=none;
        d=google.com; s=arc-20240605;
        b=DB4KcRKAROFeN2tWw4a9FkYmLE3v9Pi8wdv9uYVYipaDy84ob2mW6j+Jb2LOtHZ8dK
         JRybKe0mjVLKEMqCBZfXHRPn4t4VknP01UKiBIdozAdK58SLHOt4ICR62QAu+V94zyie
         aBuMDNhSGeNLOo5FNaxqRy1OItns1htJXINhT/IyTr5Ming//nSe8vqMA/Ms7jAAMGjR
         2VLodBiSDey5tXoG/e5MdpeCNp4WLivwRTEEcP2kdYn/hHpj/uiUiDKCL3Swc8kPafPb
         0sP4QbwkpHv+Z8lLTeTAumcUR7JJcXiAa2CzVqxTBz1VmxGj59gubiEqxu3+4VsvTjhI
         E6pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=wWJQJSQM4MiepsuGDOp1upIX0oDFGMRimS+E9jTjoNE=;
        fh=l/mBXrBsif/z5QHUbECDZJwOd6YRRAwkNV2v2jbNelU=;
        b=N28G4j4m94gk4TGivZ+4W8MInclDw/BxHJWST+81wrZWSEJTs+pbUYl3v+1z7EOCHH
         g5cedIybOpk8eFUNX2rRp6F8zP5SstdqHp2FRN2iyDHX/SZ8rQjw4xj5AySTLHBhHbpZ
         FEbUZDkn/82qS2RJtXzkOvqc3rxbeIUp7Zr+OvC4p6JGv7eril5qWkoV3VxBI6lgfoK5
         D0bMDS53GCoDSdVDXrAyQKAHKSdtjtJ0sYYte10tc/k9X7JWO+oJAum1i3knjbSodO9+
         PMaTgmilZw1iPfHAsRyXQtz/FYMdHhsPk8+SxPHsvkQLRM0QLhbrlA/yQ7zyxABKnOQe
         tOSA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1770297868; x=1770902668; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wWJQJSQM4MiepsuGDOp1upIX0oDFGMRimS+E9jTjoNE=;
        b=qw3DsE13v7+EoTqjyjal4HGchLU6/Kz4inyuxlaBwiJJpIo1o1GYheITKd/nGBeh0V
         X9lXAQsLBlqt4PWxbaGuQhqJYgpRRWBh9dy5pgJybPNLJ71rAWmWZXdOlC+TwEVCTJul
         jKEjdrmfmqXZdfHcmlihvxaz1ch5SJ9yoZVErymoNjflHeXEYURN+BDot24MrZ3/R85j
         JZ/HYqGE+yqRaJ+GIzH3FjWvJwGRWOv0SJrQEcGDtk4pOkqxCeYKZcWcwD6liC7GbZmF
         H3yxegOoG9py7XaWsEEUnF9T9byDtmksuI1CO58GaXc2RRg9+ublVRAiULfVV0kjUeIQ
         nQoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770297868; x=1770902668;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wWJQJSQM4MiepsuGDOp1upIX0oDFGMRimS+E9jTjoNE=;
        b=GElfgp4cUmVyk5U3jY4tw7BGbox7Xm9k1UHAQGEcaSrV453xD42QLaAI9Bb/4UCY9A
         2RhQK4q8xVsS5PKPBn5K9rQtVbG4NljIJ1nVa3kEwNOtJtK3rsNSxZ8nprQDfofAkl5o
         iLxMMOGfRnOCHLGoFNLcZYlRokJkrE/5abuIoJvWGvNpWL2L/6J0gZpBpuZXXVPu69+Z
         Wve131NMVE8ta6kOimP02n8kE4J6rBvjhSQtaL9ArKXAfeorF7HbFOWiyf6ygoWkVmp5
         tN7/dLrQ5iTVjNxFLUfn2NWBey5VoGeknIJZGUtlbb3scetwYeOtB+q/uH9jgGXpnluY
         GHLg==
X-Forwarded-Encrypted: i=1; AJvYcCVBcO56uJsP5kWBoXVHrJhaPGLn3dQeVIKqrgeJh7FY3iIuSVvqjGok3H25z6RPy6k+hdIkO58=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxmp5ohdkeUQE5Y0HDRsSqQIaSWuZU7KrTREWybH/ahjNV9LvI5
	E8HR0ZgT8R33A6QlPlqxrbQI/4tMgfk8x+4Q+E9Xq+jZ4if+9ezitQ9CibbZ4YYR0oduivo57Cy
	ZYUBV+wXJqAyJenP9/h4ue/Np4pobu8OgVDXGVI8d
X-Gm-Gg: AZuq6aITiKh1UEqm3Vek2OBcKtXA7fgOdXNi0CwgFsD/UZvfVst6p6yfzy41BTtpKJg
	PaYfaJMzMhLjirdogwAw47CEycKLZBJov4UuPLR9f7Ft4zZ+Nd+8QGb4ALsgVv/b43/qLpZ2U+Z
	lQkp42RbNhVj6p87BBDgYZgwPpM2t1mKMmjGBE748vG7zfZz693RTdBkkwkgpFFgI+wisG1H9Qs
	SeCaRzJI09dcBCOEeH/OxcSGIgtVZAlOzaawiuaXDmmX6oZORuce43j6hFtELA76pHld1OKp92g
	106YT/IdMA==
X-Received: by 2002:a53:7205:0:b0:649:c19c:eb88 with SMTP id
 956f58d0204a3-649db4ae1e4mr4304752d50.68.1770297868399; Thu, 05 Feb 2026
 05:24:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260204132428.224465-1-p@1g4.org> <20260204132428.224465-2-p@1g4.org>
In-Reply-To: <20260204132428.224465-2-p@1g4.org>
From: Victor Nogueira <victor@mojatatu.com>
Date: Thu, 5 Feb 2026 10:24:17 -0300
X-Gm-Features: AZwV_QiIasAvBGy1qaVysi7TUiI88O9EzRAY9ErTDlI3XE43KPKDUv_79hUS2-w
Message-ID: <CA+NMeC9wKrU0PmLKe8k=MRsDk+T6F65Gqz4hpsvHP0=_-qjVLQ@mail.gmail.com>
Subject: Re: [PATCH net v4 1/1] net/sched: act_gate: protect parameters with
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
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214458-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[mojatatu.com,gmail.com,resnulli.us,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[victor@mojatatu.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: CAA1CF33AC
X-Rspamd-Action: no action

> Convert act_gate parameters to an RCU protected snapshot. Allocate a new
> snapshot on CREATE and REPLACE, swap it under tcf_lock, and free the old
> snapshot via call_rcu() to avoid races with the hrtimer callback and the
> dump path.
> [...]
> @@ -323,23 +393,9 @@ static int tcf_gate_init(struct net *net, struct nlattr *nla,
> [...]
> +               err = gate_clockid_to_offset(clockid, &tk_offset, extack);

I don't believe you really need this function.
You can get the tk_offset once after you've determined which
clockid will be used.

> [...]
> +
> +       if (use_old_entries) {
> +               cur_p = rcu_dereference_protected(gact->param,
> +                                                 lockdep_rtnl_is_held());
>  [...]
> +               if (!tb[TCA_GATE_BASE_TIME])
> +                       basetime = cur_p->tcfg_basetime;

This doesn't look right.
If you have an update that provides a new set of entries
and not basetime, you'll end up updating basetime to
the default variable's value (0). I believe the same is
happening to the other attributes you are looking at
here - prio, gflags, and etc.

>  [...]
> +
> +       if (ret != ACT_P_CREATED) {
> +               cur_p = rcu_dereference_protected(gact->param,
> +                                                 lockdep_rtnl_is_held());

Can you try to acquire cur_p only once and reuse it?
It will look cleaner.

> [...]
>  static void tcf_gate_cleanup(struct tc_action *a)
>  {
>         struct tcf_gate *gact = to_gate(a);
>         struct tcf_gate_params *p;
>
> -       p = &gact->param;
>         hrtimer_cancel(&gact->hitimer);
> -       release_entry_list(&p->entries);
> +       p = rcu_replace_pointer(gact->param, NULL, lockdep_rtnl_is_held());

You won't always have the rtnl_lock in this situation.
For example, if a gate action instance is attached to flower on an ingress
qdisc, this might be called without the rtnl_lock.
Take a look at what act_vlan is doing in the cleanup callback.

cheers,
Victor

