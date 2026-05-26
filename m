Return-Path: <stable+bounces-254449-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qLmWKsYbFmq2hgcAu9opvQ
	(envelope-from <stable+bounces-254449-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 00:16:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1252B5DD23D
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 00:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 72ED230237FE
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 22:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42B23C5856;
	Tue, 26 May 2026 22:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="aNk6PVhn"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384863C13EF
	for <stable@vger.kernel.org>; Tue, 26 May 2026 22:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779833793; cv=none; b=awn8yEM4L36kbv4GXMzmFxDxMRr7jT+wsD539tZiUQoeTZdp5BZK/X4aFR6+uxkzHBzM4Tk/EalTPkikW8gFb3muE3Q2KS1FMUxB6h/cqnWtmSnttC9jH2YW+GqgYTB+42L3v8wjTBKsI3jnxbsyYcgq8NVg5YNGUXianb2pI/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779833793; c=relaxed/simple;
	bh=8XRM4wiJ5jNXpJetksnmAVa5jpDVg6ilKLOp4qDmY8U=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=Hb8Hvy9Nm8qnHSrPi9vsGYczEGg4PsF+arhECR5gmh+8W1QZ6tpo+A65xRdVRm56XaWhyESBYkTMps4FjCPi7ZElq1rvIJcP/5dwy7xFfTX52Q+DY1nO6ZNMNlfOgimgSLREHKhpro0H1eKOMYWVr3ZIW2Lp9mCYieZ/gwF7GlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=aNk6PVhn; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-836ed29d1e5so4909283b3a.2
        for <stable@vger.kernel.org>; Tue, 26 May 2026 15:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1779833791; x=1780438591; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QXPmI5+ogRi0iUoso0vRs88WKRO67ENSRqzfnBRQpWM=;
        b=aNk6PVhnuElr7GD/d1bCzglzRHDgnYvgxdXWI8BTY2pnaPi1k6DdjC/pAPoGbKChu+
         vK2mAphY3VfSLhdQsl6J93iW4ZW5TIZhMI3agK4FlafYg5sefRWplcB/BnjSom/m53KX
         IW9jvIB90u8Wp70NrxnyAEtfYsnPT1z4Ur+goyQmG+/oy8b/mc/UGleOdkNeo+KW328H
         N7FwFfcTXSzBe25UKiwrwGItDd/Ba7zegdHXcIRjzZbXU3KaPApDME6xfATIXRY8LQci
         Wi55ec5nLN8Hidb9sKKBZ6UkzVstDyRlH/LBPwl8n6UaQJZjZ3PjwUIJyHxT/gGpoAiA
         zYUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779833791; x=1780438591;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QXPmI5+ogRi0iUoso0vRs88WKRO67ENSRqzfnBRQpWM=;
        b=P7DBulsf2pgP1nZDlzwMEIgCRMAbZhWW3rJnU0jPoO8JJ9g5bXtBzhr3yXWK3rJVsL
         pJ6jj4DdePNHQJSrDS6evZScIeRqQzA93am5Acney6vpUSW4eSrEopY7mKweNXHHagwz
         /PeAqHuLO4Iv83GcJq0ICRszoFWMQ2LYHBLjOLiVu+r/MTsAJFxjd3z8/61UOiUL8ygp
         HDWNbpJ+KDja80ECNbja0umdvaW6V4bFovExMccD6oOB/eaUdfQadIkNllbOoe7m6IN3
         3J95MOmaVJZZ4Htoo6E5yVQLAl18FLT8MgzdPQa5fI4ZKjRezsdwP0TE8ym6MeuiF8S9
         EZug==
X-Forwarded-Encrypted: i=1; AFNElJ+ojeWVWpz+L+Ivm8/U9/yGvF6OCZFGbD1Nyzt/V+mf0McvBLFacwPj2ePSjZYdW1h26vJEios=@vger.kernel.org
X-Gm-Message-State: AOJu0YzR+d/JltGbP07JTG9t1wszsbU6Ue3BXH6nh+8ecNqV6N2+sDn7
	KIFnB6bRLCCar+tA5JvyN0NVekmurBr5Wik6Rt3+HtISWjuVJy6YKQ9E94YbxK1Iw3A=
X-Gm-Gg: Acq92OEFP4YO9YyV/EVGqWurz/Ipgdrtco1HqtwTQ+OyM7qCCdJLsL1B+pJRa7wNxBJ
	1vRRiD2WwUrgQj/pf6rcywGwCNKa6no0TR3v4W6RJIwGIYjjWhC6ACptgHlBgxzBzUqzFCK3yqt
	KD3XwYDQFf7ZO/xsMslSGOP+c0APQFWjC/pvsixqd6ddGQG4+fpeB0mRztM+Fq7KYoC0FZPJDEZ
	5rnfHYiMIVwmP5uBt+LHvnkIJ2Tc/LFp9N2wzo2ghF14Q+nmmZeVuYoS8e9f5cyLR06T7JT4Mrk
	O6/E1GuJSIaGRkYNSbKLwq7arV8m7PMSBksA6oqlMxlAV9pWXGDgLOomR0AdqHj6xky/NoNiTMr
	tJiK0uBpXcAdO5Et+CoS+R0plrD197dNuh9TwHlMMMziT0AC27Zh1oXAeWUJDbn0l8OUmJ5rUj7
	JQrSHaiO4eAmDJvy0YzGnvk6xxqMZnf8p2I/U=
X-Received: by 2002:a05:6a00:f03:b0:82a:6f69:7f72 with SMTP id d2e1a72fcca58-8415f588372mr19630265b3a.47.1779833791493;
        Tue, 26 May 2026 15:16:31 -0700 (PDT)
Received: from localhost ([2001:569:58a0:da00:a5c8:c4ce:f7c1:40c1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-841d70bb18bsm305464b3a.34.2026.05.26.15.16.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2026 15:16:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 26 May 2026 18:16:30 -0400
Message-Id: <DISYF7LAA8C0.55I0KJ1R3Z2L@etsalapatis.com>
Subject: Re: [PATCH 1/2] bpf: cgroup: fix sysctl new value replacement
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Dawei Feng" <dawei.feng@seu.edu.cn>, <martin.lau@linux.dev>
Cc: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
 <eddyz87@gmail.com>, <memxor@gmail.com>, <song@kernel.org>,
 <yonghong.song@linux.dev>, <jolsa@kernel.org>, <kees@kernel.org>,
 <joel.granados@kernel.org>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
 <jianhao.xu@seu.edu.cn>, <stable@vger.kernel.org>, "Zilin Guan"
 <zilin@seu.edu.cn>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260526131035.1312864-1-dawei.feng@seu.edu.cn>
 <20260526131035.1312864-2-dawei.feng@seu.edu.cn>
In-Reply-To: <20260526131035.1312864-2-dawei.feng@seu.edu.cn>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[etsalapatis-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-254449-lists,stable=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[etsalapatis.com];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,gmail.com,linux.dev,vger.kernel.org,seu.edu.cn];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[etsalapatis-com.20251104.gappssmtp.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[emil@etsalapatis.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.978];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,etsalapatis-com.20251104.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 1252B5DD23D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue May 26, 2026 at 9:10 AM EDT, Dawei Feng wrote:
> Commit 4e63acdff864 ("bpf: Introduce bpf_sysctl_{get,set}_new_value
> helpers") changed the success return value to 0, but failed to update the
> corresponding check in __cgroup_bpf_run_filter_sysctl(). Since
> bpf_prog_run_array_cg() now returns 0 on success, the legacy ret =3D=3D 1
> condition is never satisfied. As a result, the modified value is ignored,
> and bpf_sysctl_set_new_value() fails to replace the write buffer.
>
> Fix this by checking for a return value of 0 instead, so cgroup/sysctl
> programs can correctly replace the pending sysctl buffer.
>
> This bug was discovered during a manual code review. Tested via a
> cgroup/sysctl BPF reproducer overriding writes to a target sysctl.
> Pre-fix, bpf_sysctl_set_new_value("foo") was silently ignored: the write
> returned 8192 and the value remained "600". Post-fix, the BPF replacement
> buffer properly propagates: the write returns 3 and the value updates to
> "foo".
>
> Fixes: 4e63acdff864 ("bpf: Introduce bpf_sysctl_{get,set}_new_value helpe=
rs")
> Cc: stable@vger.kernel.org
>
> Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
> Signed-off-by: Dawei Feng <dawei.feng@seu.edu.cn>
> ---

The bot makes a similar point, but can you swap the order of the
patches? Patch 1/2 makes the invalid kfree more easily triggerable,
and patch 2/2 fixes it. Swapping them avoids the issue entirely.

>  kernel/bpf/cgroup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> index 876f6a81a9b6..8715a014c21d 100644
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c
> @@ -1935,7 +1935,7 @@ int __cgroup_bpf_run_filter_sysctl(struct ctl_table=
_header *head,
> =20
>  	kfree(ctx.cur_val);
> =20
> -	if (ret =3D=3D 1 && ctx.new_updated) {
> +	if (!ret && ctx.new_updated) {
>  		kfree(*buf);
>  		*buf =3D ctx.new_val;
>  		*pcount =3D ctx.new_len;


