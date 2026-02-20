Return-Path: <stable+bounces-217585-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yL2uL0uHmGnKJQMAu9opvQ
	(envelope-from <stable+bounces-217585-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 17:09:47 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 58240169312
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 17:09:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E305A304C7EE
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 16:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 758DE2DECC2;
	Fri, 20 Feb 2026 16:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="itukhgaO"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF9B241695
	for <stable@vger.kernel.org>; Fri, 20 Feb 2026 16:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771603782; cv=pass; b=lJOWX3ZwcRNN5ZgsAqxLOL3rCFIhXZxT9kB8S0FkD8T2cGFWPZL9xezlPXgowt95QgCqlCCcWV3dW4SQ8OAff6i/qqYt/UXIw7a/znHnIFM8ykBJQhluUnudcOk/RASkKApE1B509P5l20B6/aiiSzI6lTNPs6nj5HbYOzf16q8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771603782; c=relaxed/simple;
	bh=CkESwBbR0rnloachcm4NmkXc/MqZEyj+IlOCJu/zwcs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VFtjDxokFkOb/j9VG07BvXLnd2FM2EDQR/t4nGx+3mVu+tVsdg4pJWivwoXaqjKspyt/sm5v4HhZjgMFDUc9GYyD2z6ffmxFRWLgQKsSGk1oC4m1QU74W7NGB3sa33Fff0YSVs28ketjxd3I/q1zvLuR0JUvZVJ9Y0xXKUvqy/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=itukhgaO; arc=pass smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-64ad79dfb7cso2280855d50.2
        for <stable@vger.kernel.org>; Fri, 20 Feb 2026 08:09:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771603780; cv=none;
        d=google.com; s=arc-20240605;
        b=IikNpouhk1g5urn8b9+RE3flg3lCG1yT3XMAhIE1GM1O8S4sQ6guBdbL5RNlgJaivV
         Ci0nn1jGXmYxwTRRsFBRZrPJzaaBRMb9zgyCV7mC8aBqKt4iXlFErX+HpZcTi7EDCLfi
         O8c3sWW2Cd+vJLTZsnz68c6b4jLIqRseh/C2qExdoyhdTdD2OQDBF+jaovm94ajc4BaG
         jhq4zqnRFXZfe0ItDbUdnUNJcfccAIfYgtLhK4Lil0TdKt70+hegF3L9ovEdE/Nban3S
         9PtyVjjw5mNohzMsAtv6DFilclInmvuMl2H5nV+aS5PpJA2ZmyPS0XfKmQfVP6YzoLxX
         f+YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=SAdLzQJSZy6AcLPGK1Sc0B7gJ0DScQyLuGelN0a9WwE=;
        fh=XWqR+rpxeb82sS2EqFqZVLo/6G0vOpCvlBhwqU8kdr4=;
        b=i12WU+PxFXSOxtYTmNryQhdKpsIBrCGQqNSC5vfE4zqH025tkBSJHJJB5CmCxcPhLd
         xuFUs3277soJ7j7HpW5CNhuMFy4H2gKBlqAMPUM/b6Fm5GWptmVM0sG9yI/g1CUAG8uS
         D84TeEMXqfwj7SlRgn/PxrW5hiBNWx0HkWl2Ggw3kGQpRQqRJyklN1FO5A1NcfQV2vFi
         I/fPLkDWiV2D5M+Zo9/fTPoNrm+fCMQZfMJrNBRPSS5leuaRePFueGIhsTJVaivzQ3eM
         zn0D7QhHuc2ts6lKUyOOgIzehigvqEDT4giQiw2h5JBzfUPFRk7pQeNfMP26k9zSltY+
         AkXQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1771603780; x=1772208580; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SAdLzQJSZy6AcLPGK1Sc0B7gJ0DScQyLuGelN0a9WwE=;
        b=itukhgaO2KCOMh8z79I9qIZPSDfr1iugOsyKQIwutw2RV805IbIuNb+9D9uyT1NRnk
         UK/AGs/DMtxaXDwCW6zA8m03mN3YkWrHhjaPr6Rxp5jsLvvplKcPAk9kGJDg/WuP8d/k
         XKo3V9nRwYc4TStU/dExLiREaEVWN01AOBF4krVZgg+zOPsul9t+uFHQqtWTj4ezXxaS
         7nTcDo1J9Z3qSoDJCT8OkUeQbzCyKOttv8fqwkMpGrA1koBWh9ElWSuENYjDAwmocqHf
         /bdczzDhIWMX7bMe4b59t/pfJFQKtiIJiN4v8u4jwJwu3ZbT5gM5tMzK4XtkisIWetV4
         KOGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771603780; x=1772208580;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SAdLzQJSZy6AcLPGK1Sc0B7gJ0DScQyLuGelN0a9WwE=;
        b=rasu7Kr7tQlFJA4Z/Y6tPS8Lszm2m1Xwe5zI9JqHDJaFEMEYDjcRmF/gv4P3kXdI7J
         1LCyBwVC79aU3dGNsuwyvHAzfjEmMvtEa2+9kzx8ar4stF8q5Yj7w0VULULyu8apCksC
         5PhqwA78Uoem3/7TwqfYaE8K8SAnMhHTU5JcHfINTY6rqWVDklXQFtnadGowDeRGdIwu
         D7vREDjZ+yHapuQ2DcrrDjs277Hfvjpc2vmaFPqUFN+n/SnlYP7BcJK2SwTugIp3ILhD
         H7oOm4l+IFMiACI5l5BgEDEkHa4aqy6YB3pL/J55r0ajR9fp9HEXVffOHmwsPhvOtkma
         5q+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXcElrcT1xDDukfolf5dKNNojObTUNYkDyrIk2gSG1EsptNyXIL9b/S6F2OcsoWtZxSPcemoeg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOO0lXwqUBrsDQi/LGitF9PBKurTamgDa5HNuarsxhJVxBtHt2
	K9zhIdehV57MBZAAuFf5VUTAI+6IrYtHY539V3o5RhJhnhSSQtxzum/oehUCoBsiI8IBY8nuZOr
	ilXjj+qnmZ4td2kYMO1s49ZwtptoZ7+QWr5zxsytO
X-Gm-Gg: AZuq6aJPVguxDC9x7BEV2EWwh5bv6TX/OXNuc7grm9iHu1Vc/ylraP8c9bQJEkX4es4
	FRpQmueGVdcm9fjj1DfhCuV/URk1MlU8X/kUq6QRx/+GwU+BBgkRJu1t9F7oTaH00yLAChMp9Rj
	7Eu6+V3okBpy3BuDEe6A8SdchgqFbsYnHS5GmiyYvJJQat0R+SSZ5cYxY3tses2lYHhCyma2yPW
	+0uj9I8m5NaVtpH3luMt/gQxkAANqd10VpXXolrO+Eaz8J1ySsNmXaorNlSKj9qGRJ4cohaRpKo
	iZ2Qh+JMCgR3KwRH3hXEpDXZcOLUCEF9
X-Received: by 2002:a53:7701:0:b0:644:60d9:8649 with SMTP id
 956f58d0204a3-64c790a96b8mr135031d50.88.1771603779752; Fri, 20 Feb 2026
 08:09:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260219023151.171753-1-p@1g4.org> <20260219023151.171753-2-p@1g4.org>
In-Reply-To: <20260219023151.171753-2-p@1g4.org>
From: Victor Nogueira <victor@mojatatu.com>
Date: Fri, 20 Feb 2026 13:09:28 -0300
X-Gm-Features: AZwV_QhyUehe-pEspw2ceXPuL8NPY47i2uBjfDAaUnsA15wcOWcjumMXOboVa8s
Message-ID: <CA+NMeC-WmxL48X5dSqGx5+2T_dR8B_g5C2BL2Hre_HG1-UkXDg@mail.gmail.com>
Subject: Re: [PATCH net v7 1/1] net/sched: act_gate: snapshot parameters with
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
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217585-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[victor@mojatatu.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[mojatatu.com,gmail.com,resnulli.us,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mojatatu-com.20230601.gappssmtp.com:dkim,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 58240169312
X-Rspamd-Action: no action

> The gate action can be replaced while the hrtimer callback or dump path is
> walking the schedule list.
>
> Convert the parameters to an RCU-protected snapshot and swap updates under
> tcf_lock, freeing the previous snapshot via call_rcu(). When REPLACE omits
> the entry list, preserve the existing schedule so the effective state is
> unchanged.
> [...]
> diff --git a/net/sched/act_gate.c b/net/sched/act_gate.c
> index c1f75f2727576..917974b68c3fd 100644
> --- a/net/sched/act_gate.c
> +++ b/net/sched/act_gate.c
> [...]
> @@ -375,25 +472,26 @@ static int tcf_gate_init(struct net *net, struct nlattr *nla,
> [...]
> +       if (need_cancel)
> +               hrtimer_cancel(&gact->hitimer);
> +
> +       spin_lock_bh(&gact->tcf_lock);
>
>         if (!cycletime) {
>                 struct tcfg_gate_entry *entry;
> @@ -404,20 +502,22 @@ static int tcf_gate_init(struct net *net, struct nlattr *nla,
>                 cycletime = cycle;
>                 if (!cycletime) {
>                         err = -EINVAL;
> -                       goto chain_put;
> +                       goto unlock;
>                 }
> [...]

The AI says:

"If this error path is taken after hrtimer_cancel() was called above
(when need_cancel is true), does the timer get restarted with the old
parameters?

Looking at the unlock path:

unlock:
        spin_unlock_bh(&gact->tcf_lock);
err_free:
        release_entry_list(&p->entries);
        kfree(p);
chain_put:
        if (goto_ch)
                tcf_chain_put_by_act(goto_ch);
release_idr:
        if (ret == ACT_P_CREATED)
                gate_setup_timer(gact, timer_clockid, tko);
        tcf_idr_release(*a, bind);
        return err;

The gate_setup_timer() call at release_idr only runs for ACT_P_CREATED,
not for REPLACE operations. When a REPLACE operation changes
basetime/clockid/tk_offset (making need_cancel true), hrtimer_cancel()
is called. If the subsequent cycletime validation fails, this error path
never restarts the timer, leaving the gate action with a permanently
stopped hrtimer.

Should the error path restart the timer with the old parameters when
need_cancel was true?"

What it describes won't happen (at least from what I understand)
because your current code won't allow zero entries and the interval
parameter can't be 0. However it has a point because, if cycletime
can't be 0 anymore, you should remove this error path altogether.

cheers,
Victor

