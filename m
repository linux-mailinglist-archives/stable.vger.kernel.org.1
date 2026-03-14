Return-Path: <stable+bounces-225412-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yBwgHmcstWnNxAAAu9opvQ
	(envelope-from <stable+bounces-225412-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 14 Mar 2026 10:37:43 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE67328C67F
	for <lists+stable@lfdr.de>; Sat, 14 Mar 2026 10:37:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E0061300D171
	for <lists+stable@lfdr.de>; Sat, 14 Mar 2026 09:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A5731E859;
	Sat, 14 Mar 2026 09:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="BCtUQJE1"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5CA1A3160
	for <stable@vger.kernel.org>; Sat, 14 Mar 2026 09:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773481057; cv=none; b=AiGRbiCeI9cbRVg7IRLUAmoVIJo4SmK4pg0bjRpVezM2CefA0FZwhopEYdpi81x/kQ5l1jZNFgti+o8a9ol/I9C8LzxeRssVZQbit7Aowp1EATYTetAxP3JrXYcq5oc8aAuhkpOq6ad5Z/MRl33hq/Jh70UPbjTwBHNme9k/F8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773481057; c=relaxed/simple;
	bh=PW82vmyUoBo5SVpPvpbFQcYkYuhkW+kzsIfiM0ZCnUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YPKmz+69iUhxHXeXZWBLERhq6mkR4eSR7Pfs1dZ/rw/UoDLDvTEV54E9tvspDG7ihVNrEAIqc6dhQ316ueADc8pCt0w6KjnKWOF6lk/7T8MZ1akf1lfQZCUP2LUR3XwOrxF0CRNyvgxmpbmPDNInixhxysdM+LUOQUEg8XPWQ1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=BCtUQJE1; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-48532925a4bso15162265e9.1
        for <stable@vger.kernel.org>; Sat, 14 Mar 2026 02:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1773481054; x=1774085854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VxsA2YZ471Q/xGiQuKEeLiqvlRJiwCfIC45xI+go3Hg=;
        b=BCtUQJE1Rhvg2C17QMxGnp6flTDLEW3x1RPaYtxhVGqxIE21LJeOMOkPUHDuJLIVRA
         O/1IssRmLAFe0LXojhHfrt7WeAmvyXb631QakA46BvEt+RB+pIZZ3x5OjfKQaMPinTA7
         NBPUeweElMXn4MpSyFsQLtwGu951wZt6f8rXmkYGDCB5Km1tvd6QbYuFv2ikAN2UQ6d8
         VFhwBMmMK2FmeCyVpd1YDD3iazX/heb7XsrMGg+2WzCZrrg9hgU1nForLEaHiXlYOOe9
         OSusbP5LQrXZQLhJv+3QCTAVbePFBqgNEymJ+yHJJfmW2+n+v8enwMmcY5Mm+bUjtsj7
         Qb2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773481054; x=1774085854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VxsA2YZ471Q/xGiQuKEeLiqvlRJiwCfIC45xI+go3Hg=;
        b=lvfc8IDCvWQ6cr7OM/G0WsTDkbxaHNz/yOfWQPQU6BAyXQ7MyidIlk+64aITmROvaM
         6pmGlr5tCOrmm+0Kor/NtVTuerZU98UDxb5K8cXr0KU7E+4EpS934oBaRx0vhwEFeniJ
         SgD/S9YEnRb4Cd679TWQZ5wBgI6U50Go7LpJ1C2GJWfyXZKDxGneA9JvCA87aExD73pb
         r2TxntcgPMBWhAmgRcy9AgVqZTNQUJV2zUulcySbrhyeNZfwgF+rsdjkR7F8yyO2EuVF
         LF2i/uxXg8tvrYq/wgFL98IQLNo6xuSC+gWELDSJ1kglS0TcbRvcO0wTwwkLPwOF/F4m
         Upcg==
X-Forwarded-Encrypted: i=1; AJvYcCXjhBqWKQp9jgaKzvXCG0u8weumiZMZp5PT5CeMZ7npS/SUXzr2o0qXr4SC+zzU1wcaKYkGieA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoNz0m5M5a9T3kl31CKp88Ylp2rPR/BoUIrJXKa3HhQZ7RY3IK
	3lljfUh+2ueWPMUwizSVbfKcioQ5xMYSFOez8XyX5o8YYlafiZF/Za+P
X-Gm-Gg: ATEYQzxsIoli5LqdRthwNzcPTMlHMjMNGNMTC3rmdaK7MsJAcwxUspWGouLgWe53Vqj
	C4gbqBjrL8OuKjJo37tueDfVBqPzSA4OoRmWJDmRycWsrNp5Bx7Z7crI0UVIRmK3fBil88FF+DE
	laFaXyR2eO5bvBMjtuHQFlUc/H+KiHt+3lyvbcQ8MWNkLEn4fv5iS1bCaxo4vSW+e+8d2rrgHWZ
	kXVm0fKQJJAciSDyUl66jJj4NtOab7wnfh03N/bMsTROZMb9kqqgIbnOZ8oeu5ApDe7qnod8Y5f
	YJFN1VGFxbRoFC1QGC0FMr65CjKy3gtY1ZBy1KvAJXEuf11ydw4mfozAFgq4nqoY/90tD9U3/i+
	XujdeqAH3Oo94Y2mcZmyu+tFRoJ5fXVJzYSwX3gWeGzDH0sXTOUf8+kEqhTtQBgBwN3RPM24snN
	rJC3Sj9VkETtQR5b0Pc5bMgvOXiBCkXRruoBOtt11LNM8=
X-Received: by 2002:a05:600c:1388:b0:483:badb:618f with SMTP id 5b1f17b1804b1-485567050dcmr98705965e9.25.1773481054070;
        Sat, 14 Mar 2026 02:37:34 -0700 (PDT)
Received: from ccde1gl2920.wdf.sap.corp ([130.214.226.57])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48557c89186sm113974345e9.1.2026.03.14.02.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 02:37:33 -0700 (PDT)
From: Marc Buerg <buermarc@googlemail.com>
To: ps.report@gmx.net
Cc: buermarc@googlemail.com,
	elias.rw2@gmail.com,
	joel.granados@kernel.org,
	kees@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH ] sysctl: fix uninitialized variable in proc_do_large_bitmap
Date: Sat, 14 Mar 2026 10:37:25 +0100
Message-ID: <20260314093725.12429-1-buermarc@googlemail.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260313121708.137dae22@pc-1>
References: <20260313121708.137dae22@pc-1>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[googlemail.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[googlemail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225412-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[googlemail.com,gmail.com,kernel.org,vger.kernel.org];
	RCVD_COUNT_FIVE(0.00)[5];
	FREEMAIL_TO(0.00)[gmx.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[buermarc@googlemail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[googlemail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[googlemail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,googlemail.com:dkim,googlemail.com:mid]
X-Rspamd-Queue-Id: CE67328C67F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello Peter,

Thanks for your feedback and the idea. You are correct proc_get_long()
does not set @tr if @size is zero, therefore, left in
proc_do_large_bitmap() should be zero when we expect @tr to not be
written to and c still being uninitialized.

> Would the better fix be:
> 
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 354a2d294f52..89db88552987 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -1427,7 +1427,7 @@ int proc_do_large_bitmap(struct ctl_table *table, in=
> t write,
>  				left--;
>  			}
>  
> -			if (c == '-') {
> +			if (left && c == '-') {
>  				err = proc_get_long(&p, &left, &val_b,
>  						     &neg, tr_b, sizeof(tr_b),
>  						     &c);

This would explicitly fix the problem as it enforces that we only check
if we know c contains what we want to check for. Fixing it like you
proposed seems better to me.

I am somewhat conflicted because leaving c uninitialized allows that a
similar problematic access of c could be made in the future.
Initializing c could prevent that. I also do not see an immediate
downside, but that could just be my naivety. Further, that part would
now behave similar to when we apply the default hardening configuration,
if my understanding is correct.

On the other hand, we do not read c later on, and I do not see a reason
why the function would change significantly. Still, it feels more
defensive to me to also set c to 0.

In the end, I am not so used to the kernel coding style. Is there
anything that can be argued against providing both? If you think this is
unnecessary I am happy to follow your reasoning and go with only the
check for left being non-zero.

Kind Regards,
Marc

