Return-Path: <stable+bounces-242196-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJSANbCq82kd5wEAu9opvQ
	(envelope-from <stable+bounces-242196-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 21:17:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E37F4A757F
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 21:17:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9EC60300F9C0
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 19:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C27834167B;
	Thu, 30 Apr 2026 19:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iLkp5laK"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A52928C037
	for <stable@vger.kernel.org>; Thu, 30 Apr 2026 19:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777576618; cv=pass; b=iQLMr62DMOZf24WegDUyvbG5cmnR4YNjYsCDktcljSCV32uimSTXbaS9faJomZOsMwYEBjeOr7RAoBMFeaya69vyquu27DK7m+TB7gCeTpAjWWd6eDU0uaBTZ8ipbZqyIevBjYx4oyouHnY0vKgSPhUBMlvsP/P5yUKHhOZkR30=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777576618; c=relaxed/simple;
	bh=xDvPePKfH4SYIJvgq6nsiD90KSKxun/X863JKt5atPs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QETVVDGphtwxFijm57Mdr5XQXkY5XGo1gQrVDKRMn83udFwq+8C+jrs3tL9OLEatzVmud8msLTb/VfJXPopw82a65ddhBfFIv7Irz1bJksGMonzfYWT/8nAuvjDjdknunzIYRg19mm9R2s2uQi0yL96mHxJHbtdkzsxGcHC6ZsA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iLkp5laK; arc=pass smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8b5232009a6so811756d6.1
        for <stable@vger.kernel.org>; Thu, 30 Apr 2026 12:16:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777576615; cv=none;
        d=google.com; s=arc-20240605;
        b=c7EWVmAYsPh46btpQzgEkVTk3Gi67lkixYOJPuAbTYwm6qjTMGDkCH5EtGWeBPXJ8k
         kzi3hh9eiN/JwID8K9GMGoKKd8vEc2XCUNpLRVX10Jlcua6e+a26+G+qkVU4MtvrsseK
         HFTFmL0IbXSv348c06R48vEEVpb6CoTNxG41710YQDYwe3ijIS7OjlmFXpOzxUMg0Y9X
         +u99iv1mFtEpy1Mt5pd6TtU+C1sh7pRQ41lGTpJQ21DcrFu3f4IclIe9BWB9sdGcZZ/I
         gJVITsfHqn1xq9J64RwkmY8DocFvFI0vmxnnjW/h2B4KKOT5HQTqb5hsDlGVSswuQ/q1
         372w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DjI6tqWA6jLZAVm/BuUGdM3lQfH0KlxWewSifCFKExk=;
        fh=tCH5Aq/eFJ1R4iHuYHL0wnG8tyCWx4/oLDvR/wyFbd0=;
        b=j6oi7SnBxQhfiBfV4pkF9T/Twmqg4L0Oba3RbINMh4Ahmzu02br8+qEsMDSCiv+plf
         xw4Dm2BgugBJrxNh6FHOqM+hZCTlaGCbF4Tzcga+i8Rdc0RHFHmHO9BaRnz7f8R7MtYu
         IJ4t1/obVeQXoQNnELZXFoeu5ceh78JYrlxCcro6Xlc2h+A6amZzOycAmptUQprWRPUf
         F0cmltabTWk7S3IkNfbpQwfIwJySgb8Nn2+QBDp1t3NUtmGzlhfwZrhpGo5Pg5tdYPML
         eRmd8KCeA7BqrjpFoCGSE3xb59Zl+J/dx808FaWi+ICPjueJU5UgPswff577w1RqjV8E
         E7Kg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777576615; x=1778181415; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DjI6tqWA6jLZAVm/BuUGdM3lQfH0KlxWewSifCFKExk=;
        b=iLkp5laKtstJrh9wvQ5TlYnnB1BzOOUXPy6sR+NKTrS/bBzBGO2C4Vu0e1Ze0NxbQJ
         xlJKibKf2DfSM1IzlzxHZZ8NOHX8667ldB2is80SCw3XeXi1WC6ShbJAkSS9oRXgmGk+
         PHZPjKOvyHzVTnfC79jBBJOiZKwbgrP1NaQDQSyVJiQ1QiSx/5bSS3DrCBuv6cGCcADb
         ebckZzwisoR46Q7rUnbQZ8eVwHqpdX43UFMJ14ASvuh71EKKH9hPlPlfRubVEEe44Fy6
         vhkRj0mzHUQZNuXeZanT62+1ByyLC0hQoOX5h4H6eBdFp3Fsv9OGVWUj+qtii3m+hWWT
         oPXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777576615; x=1778181415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DjI6tqWA6jLZAVm/BuUGdM3lQfH0KlxWewSifCFKExk=;
        b=j4GHzep/2hwaBhjaB9Xd8SWO1pz8R5895ju1cJmIilpTP+kIL0cG10LhCPPPvLvv9I
         9tRG60+GXokVAjzjA3gH1TtmcDqGrPb47xnKOF5UkONfBOJVmTbYJPIUf3pELQ0Z1N8f
         PSoQwzZA/kdpchkQ2hc2TUmOtW6ueefbv6gVkWNSqFimiD/yliJ7EnbZk46xB/e301O3
         RUyiSAPTYOa8bQALj8J91lJQGpdavgizVQ10U3OYrgGAD0Uixwj0DOpkem33oKeuIlV2
         ei3fH0O1rvn5SqxkN7jjPAP/OboPjYEvJ9O7/7j1rG3p8+PRv9xHjsmB5MiI8TVaRPTk
         AF4Q==
X-Forwarded-Encrypted: i=1; AFNElJ9ZUrhfXu0dSIjk1iLZ3SH21RR82A2VkmgAv8yaBxpnptHn4jJTPlkG/yBrm7M3Dl3zEJ8Xe64=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQUj8Caq94slf70M4g+s6xaU1C+Bp+1lIqmcOQFwYl32XHTXok
	O4dxEn6AhZCS7BHUqnx3uFOrREHtqqFwY3fJYPb7uUg1NkdOMh/8m2E4+jyRMLbEwbUhRkgVP1e
	5PQAU3iLRvfuJeUV1YG+MOKjkjKACcxo=
X-Gm-Gg: AeBDiev2CyrJOguJcktOGqK0fTxHd2k8cxGTZX6Phx/tFcl88zG8ORTKWUGw97RQhpk
	OATDIq+2SiRLNZUWcRM1XGtrK9FbsY92l3iASIz527usVCZ4up7qHwmTvm0OPpBghPob3jdqEzG
	bUWZC2xVNFrhyDHIlOU7PSXPjoNzGXwuQS3hGSVks748NWZ57U2UPy4OpFmIvWd6BxylwChVe9p
	fgtOUhcoR2EfhU+K8xCBLq0ExYxUpr90juQQgBD3QTvjRpgcgQwJDKFyOew2OrFioRGIe3qqRSK
	KJ60fRIakMTwpdg8MBxtFMaQYm+iWt4McBDlivpL6OOUGUPP12/vEAf1M7DZraJns3ruesgPJu0
	uGNKLKPjIhUWID7mNpyGTzRsr4b8h89hpv7DLi0RI/ZRysFLnTbMP/Am3xrawCNoFGKy8e8Q=
X-Received: by 2002:a0c:f109:0:b0:8ac:b5e0:bf92 with SMTP id
 6a1803df08f44-8b3fe70f494mr54865666d6.9.1777576615374; Thu, 30 Apr 2026
 12:16:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428160804.281745-1-sprasad@microsoft.com> <20260428160804.281745-2-sprasad@microsoft.com>
In-Reply-To: <20260428160804.281745-2-sprasad@microsoft.com>
From: Steve French <smfrench@gmail.com>
Date: Thu, 30 Apr 2026 14:16:43 -0500
X-Gm-Features: AVHnY4IKz6Pr2LyA9QZ-gb-F4YYencxWRol59XhjMjNlndP_5DknAKVn0Qxqwos
Message-ID: <CAH2r5mtcNUUUH8q-TDTW1UfZVim=cfDZFegqkBc6xex=BZoRQA@mail.gmail.com>
Subject: Re: [PATCH v3 02/19] cifs: abort open_cached_dir if we don't request leases
To: nspmangalore@gmail.com
Cc: linux-cifs@vger.kernel.org, pc@manguebit.org, bharathsm@microsoft.com, 
	dhowells@redhat.com, henrique.carvalho@suse.com, ematsumiya@suse.de, 
	Shyam Prasad N <sprasad@microsoft.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 5E37F4A757F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242196-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[smfrench@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]

Added to cifs-2.6.git for-next and added Bharath's Reviewed-by

On Tue, Apr 28, 2026 at 11:08=E2=80=AFAM <nspmangalore@gmail.com> wrote:
>
> From: Shyam Prasad N <sprasad@microsoft.com>
>
> It is possible that SMB2_open_init may not set lease context based
> on the requested oplock level. This can happen when leases have been
> temporarily or permanently disabled. When this happens, we will have
> open_cached_dir making an open without lease context and the response
> will anyway be rejected by open_cached_dir (thereby forcing a close to
> discard this open). That's unnecessary two round-trips to the server.
>
> This change adds a check before making the open request to the server
> to make sure that SMB2_open_init did add the expected lease context
> to the open in open_cached_dir.
>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Shyam Prasad N <sprasad@microsoft.com>
> ---
>  fs/smb/client/cached_dir.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/fs/smb/client/cached_dir.c b/fs/smb/client/cached_dir.c
> index 04bb95091f498..64e22c064fa0a 100644
> --- a/fs/smb/client/cached_dir.c
> +++ b/fs/smb/client/cached_dir.c
> @@ -286,6 +286,14 @@ int open_cached_dir(unsigned int xid, struct cifs_tc=
on *tcon,
>                             &rqst[0], &oplock, &oparms, utf16_path);
>         if (rc)
>                 goto oshr_free;
> +
> +       if (oplock !=3D SMB2_OPLOCK_LEVEL_II) {
> +               rc =3D -EINVAL;
> +               cifs_dbg(FYI, "%s: Oplock level %d not suitable for cache=
d directory\n",
> +                        __func__, oplock);
> +               goto oshr_free;
> +       }
> +
>         smb2_set_next_command(tcon, &rqst[0]);
>
>         memset(&qi_iov, 0, sizeof(qi_iov));
> --
> 2.43.0
>


--=20
Thanks,

Steve

