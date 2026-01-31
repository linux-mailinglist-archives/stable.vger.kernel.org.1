Return-Path: <stable+bounces-212937-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qKxUJIDUfWm9TwIAu9opvQ
	(envelope-from <stable+bounces-212937-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 31 Jan 2026 11:08:00 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB13C17A2
	for <lists+stable@lfdr.de>; Sat, 31 Jan 2026 11:07:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3957E3007F47
	for <lists+stable@lfdr.de>; Sat, 31 Jan 2026 10:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FAFB200110;
	Sat, 31 Jan 2026 10:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CG+hoyTO"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFFA21ABAC
	for <stable@vger.kernel.org>; Sat, 31 Jan 2026 10:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769854057; cv=pass; b=c8+3/EMSr+uo7JPXpKzSIpLzAiIF0ItOdGuevQnzqoMrh5TnhiaBKgZaFpsGWjRIb8PPjFIsuN/H1cREril3T1LFxgLQCXdwUvtq3KvGT+fE0+Q56lOq5qkLc+v+2Pp7JZCLUowS971U0GE9OXOCEgQ0nt/aYMC1+8VA+r2hEXw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769854057; c=relaxed/simple;
	bh=I6BM5qKMHQTqFv9AaN/yS5YuzmRJeJu0XeKHoefubnU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kG56fOPKnYei7MI5x2z5SD9tzFBDT8sA0yIOzAEh31FdO8p6DQ2AfACS8V7WncFwnhWh1qsF2mMWHRVL/O3TORte2oA1TbZ2I/ozM4rSwN13K6CkQWCUvyxvqqrR5BQCqWIo1dMSmoL4tB4LQ/kBLNrTWuIl7ESUZLOJjl5esys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CG+hoyTO; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b884ad1026cso463157066b.2
        for <stable@vger.kernel.org>; Sat, 31 Jan 2026 02:07:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769854054; cv=none;
        d=google.com; s=arc-20240605;
        b=TpfiAciC7sGTT9jOvcX//E5XPrqXapuuiiOjqSm2mCm0Dd2+Bk5W4T+Qib2JTNbAF5
         SJN4qmiAYgHI8OXV6PatWcBVnNCrZhglSm1hVoy1ILND3ycIoelUqDGLyujUh6Jr389Q
         rk0bGznq97DwFtnnxRIVgzvFb9O4Oc1FY8UTv/g6yKOGMrIb/kHBjjXawTMGZkqPWm41
         pbWWJft9HotLUgL9RizKuma+FCeaBcp1ViHEtQtc2tJlDIMBXZVxWyMvjrP/YRfF8epe
         gpABd362hRTIh/Xxq+p+BN6srm36XnvT/eM1yMnaNNvsUJ254IWafRKeAO6UslqRvw/p
         hX/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ffws5UrLAUr9v0YnZlGYkxqmp7sDWWp3QAC/eDvakkk=;
        fh=0SAy/9U7oSe6DJPyan2HkFPsHVqabUtC8hoQTHyq+/4=;
        b=LcmMARH/Mu9Dkk0hPEHUhYgvvqqOz+cv1MKXo6aIsl4R1Ml7NPHWCU/EA/JkNgnMVp
         5sPwGTYzaNAl/p9D76cco+IJ5oUDrrORbJAzTflQB66zjMRLBoQyZyv6cN2ZZ+pAZHJp
         KEDE8BvtDRkBQagQvIrwwByuM+9uHRUGxDbgTsqRmX+og/wIgAfqqruEC1KdL2G2BkVT
         GyBqEaBS7UmTYwhsc+2HhYp3T3PjLD9S3nvVDS2vu8Km+UzwVXKlJzUUQQmXfmKs8KkK
         7qZNsS5MJ1gpRpZ/x3retDBQb6zX32PbYUVnvBZwvof5fvHNCj28C3eGwej6xA7ZCYVu
         WArg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769854054; x=1770458854; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ffws5UrLAUr9v0YnZlGYkxqmp7sDWWp3QAC/eDvakkk=;
        b=CG+hoyTOG4G0X7q7UXc54V7FsPR4V+wtbGeVQ9EQcIg5VhJCuSgEPm7NHIuaBSSxpz
         Fn+kTV+oYi7tfsy3i6Lzj1IrK9/PUxCfPNr1IK1SI8I/nN37BNZWNvaZAIJA4vPfH+xe
         MD6GM2Ym/vNbl27ehLQwNQVLdtF6B2EKSRkQRxJag3xRyZ7Y3CfOt06kA4Zfi8OKGX2J
         HFzQpH6N7Z5zji1FFBPdRjMUGduX9oIIU8ufWk/jb8tIwO+38E8MxdOuQDtB9haNHoHd
         q19fpzQhV/ddYUOjiHT25rbfJjjr57qjwz7nnCTpfSpQLkfwYWUu3sl+T8o8ayMAXA1/
         IoaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769854054; x=1770458854;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ffws5UrLAUr9v0YnZlGYkxqmp7sDWWp3QAC/eDvakkk=;
        b=dQe0g6itCsCV4EPuKHlRjC6T5F7uMSwZ6kVk9kT1VqOqrbk/57nKxVJoqLrHP9Vu3W
         q90fwxYctTdQjYq8RQ/M2oDu4aqOjaX4VXjhic9hx1q/rs0E0hH5yxQVDyJ5sfLkHY9d
         0v79zfjprjOCzOhjii79f4BCTuWk5pr9hvt1rb6oKFtgN6/ZbTFo6ypRFIiyAKPfLgOi
         wrla3oT2mwgXoaQrF1QoayQ7/8BI9KIKa9+IHv5gfr659hRxrhwqQmzwHNp4pQMGJ3Aq
         bS09q35kbbg2JiWXSja+1HAVYySaMlX2sBwaeJWVloG9dmbyb9pQrO9MfMOVJ0FlS2eb
         cnwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUZ0NTpppGuzFUHZU19x8EyzAAh72B3ZiFtaXg93I7RPLgkGpq/7SYs0y6cg2P0lMjeq9rhfk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7O5J2YQ8MzZMKjTh6M+VKf/2EzIADkO25uX/ov/sqqSay35oc
	ZqiJUNr76U55Y7wSI6UOkxGH9Q7z8fdzL5aqKtOCY4wjjGcH0Yrl2OwgqLcgj4TCKw06WrG7gHC
	ICtojFgFnYAYUgAC3wpt/lpX1Jen1CR4=
X-Gm-Gg: AZuq6aIKyft1hnUwol4s7DfKqiZKvVImX4TlEaktbXnhEn/KixkM6n+3GzR9CUdViW3
	ZazxeGFoSQWq6xgk+lI2uf83FuDXj3Kj7CSvPBhfYqzbf3D4J+3E4UR3nhUIiP7XnLAieTqNfHZ
	wUjjBjifnJ7j2e2ypvcGDiQD9MIfmd4sS5FFr9bHYOUyMvpxqqt83fx+svy+aAMPCNjpVbLiItD
	0Qx1jxTMzOlTsrAfMlq2AHawpkvm6ocoLNIfctAEg3YCOu9iwX5lLM/CI5kSYf7QAq/2g==
X-Received: by 2002:a17:907:944d:b0:b88:5ef6:17f4 with SMTP id
 a640c23a62f3a-b8dff57e898mr334181366b.17.1769854053665; Sat, 31 Jan 2026
 02:07:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260131080239.943483-1-sprasad@microsoft.com> <20260131080239.943483-2-sprasad@microsoft.com>
In-Reply-To: <20260131080239.943483-2-sprasad@microsoft.com>
From: Shyam Prasad N <nspmangalore@gmail.com>
Date: Sat, 31 Jan 2026 15:37:22 +0530
X-Gm-Features: AZwV_Qj-pDqy7QmjR7e3bBFk7_e7OmyTKkXMmfVBRdDgVWHRta6Gvs9LEvuB9EM
Message-ID: <CANT5p=qayd=CGCytZbbqLMgVpuMt0CgZSkdDFonD8mg4gx3eaw@mail.gmail.com>
Subject: Re: [PATCH 2/2] cifs: Fix locking usage for tcon fields
To: linux-cifs@vger.kernel.org, smfrench@gmail.com, pc@manguebit.org, 
	bharathsm@microsoft.com
Cc: Shyam Prasad N <sprasad@microsoft.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-212937-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com,manguebit.org,microsoft.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nspmangalore@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 0DB13C17A2
X-Rspamd-Action: no action

On Sat, Jan 31, 2026 at 1:33=E2=80=AFPM <nspmangalore@gmail.com> wrote:
>
> From: Shyam Prasad N <sprasad@microsoft.com>
>
> We used to use the cifs_tcp_ses_lock to protect a lot of objects
> that are not just the server, ses or tcon lists. We later introduced
> srv_lock, ses_lock and tc_lock to protect fields within the
> corresponding structs. This was done to provide a more granular
> protection and avoid unnecessary serialization.
>
> There were still a couple of uses of cifs_tcp_ses_lock to provide
> tcon fields. In this patch, I've replaced them with tc_lock.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Shyam Prasad N <sprasad@microsoft.com>
> ---
>  fs/smb/client/cached_dir.c | 4 ++--
>  fs/smb/client/smb2misc.c   | 6 +++---
>  fs/smb/client/smb2ops.c    | 8 +++-----
>  fs/smb/client/smb2pdu.c    | 2 ++
>  4 files changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/fs/smb/client/cached_dir.c b/fs/smb/client/cached_dir.c
> index 1db7ab6c2529c..84c3aea18a1a7 100644
> --- a/fs/smb/client/cached_dir.c
> +++ b/fs/smb/client/cached_dir.c
> @@ -788,11 +788,11 @@ static void cfids_laundromat_worker(struct work_str=
uct *work)
>                 cfid->dentry =3D NULL;
>
>                 if (cfid->is_open) {
> -                       spin_lock(&cifs_tcp_ses_lock);
> +                       spin_lock(&tcon->tc_lock);
>                         ++cfid->tcon->tc_count;
>                         trace_smb3_tcon_ref(cfid->tcon->debug_id, cfid->t=
con->tc_count,
>                                             netfs_trace_tcon_ref_get_cach=
ed_laundromat);
> -                       spin_unlock(&cifs_tcp_ses_lock);
> +                       spin_unlock(&tcon->tc_lock);
>                         queue_work(serverclose_wq, &cfid->close_work);
>                 } else
>                         /*
> diff --git a/fs/smb/client/smb2misc.c b/fs/smb/client/smb2misc.c
> index f3cb62d914502..0871b9f1f86a6 100644
> --- a/fs/smb/client/smb2misc.c
> +++ b/fs/smb/client/smb2misc.c
> @@ -820,14 +820,14 @@ smb2_handle_cancelled_close(struct cifs_tcon *tcon,=
 __u64 persistent_fid,
>         int rc;
>
>         cifs_dbg(FYI, "%s: tc_count=3D%d\n", __func__, tcon->tc_count);
> -       spin_lock(&cifs_tcp_ses_lock);
> +       spin_lock(&tcon->tc_lock);
>         if (tcon->tc_count <=3D 0) {
>                 struct TCP_Server_Info *server =3D NULL;
>
>                 trace_smb3_tcon_ref(tcon->debug_id, tcon->tc_count,
>                                     netfs_trace_tcon_ref_see_cancelled_cl=
ose);
>                 WARN_ONCE(tcon->tc_count < 0, "tcon refcount is negative"=
);
> -               spin_unlock(&cifs_tcp_ses_lock);
> +               spin_unlock(&tcon->tc_lock);
>
>                 if (tcon->ses) {
>                         server =3D tcon->ses->server;
> @@ -841,7 +841,7 @@ smb2_handle_cancelled_close(struct cifs_tcon *tcon, _=
_u64 persistent_fid,
>         tcon->tc_count++;
>         trace_smb3_tcon_ref(tcon->debug_id, tcon->tc_count,
>                             netfs_trace_tcon_ref_get_cancelled_close);
> -       spin_unlock(&cifs_tcp_ses_lock);
> +       spin_unlock(&tcon->tc_lock);
>
>         rc =3D __smb2_handle_cancelled_cmd(tcon, SMB2_CLOSE_HE, 0,
>                                          persistent_fid, volatile_fid);
> diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
> index c1aaf77e187b6..6f930d6c78adb 100644
> --- a/fs/smb/client/smb2ops.c
> +++ b/fs/smb/client/smb2ops.c
> @@ -3091,7 +3091,9 @@ smb2_get_dfs_refer(const unsigned int xid, struct c=
ifs_ses *ses,
>                                                 struct cifs_tcon,
>                                                 tcon_list);
>                 if (tcon) {
> +                       spin_lock(&tcon->tc_lock);
>                         tcon->tc_count++;
> +                       spin_unlock(&tcon->tc_lock);
>                         trace_smb3_tcon_ref(tcon->debug_id, tcon->tc_coun=
t,
>                                             netfs_trace_tcon_ref_get_dfs_=
refer);
>                 }
> @@ -3160,13 +3162,9 @@ smb2_get_dfs_refer(const unsigned int xid, struct =
cifs_ses *ses,
>   out:
>         if (tcon && !tcon->ipc) {
>                 /* ipc tcons are not refcounted */
> -               spin_lock(&cifs_tcp_ses_lock);
> -               tcon->tc_count--;
> +               cifs_put_tcon(tcon);
>                 trace_smb3_tcon_ref(tcon->debug_id, tcon->tc_count,
>                                     netfs_trace_tcon_ref_dec_dfs_refer);
> -               /* tc_count can never go negative */
> -               WARN_ON(tcon->tc_count < 0);
> -               spin_unlock(&cifs_tcp_ses_lock);
>         }
>         kfree(utf16_path);
>         kfree(dfs_req);
> diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
> index 5d57c895ca37a..c7e086dfb1765 100644
> --- a/fs/smb/client/smb2pdu.c
> +++ b/fs/smb/client/smb2pdu.c
> @@ -4239,7 +4239,9 @@ void smb2_reconnect_server(struct work_struct *work=
)
>
>                 list_for_each_entry(tcon, &ses->tcon_list, tcon_list) {
>                         if (tcon->need_reconnect || tcon->need_reopen_fil=
es) {
> +                               spin_lock(&tcon->tc_lock);
>                                 tcon->tc_count++;
> +                               spin_unlock(&tcon->tc_lock);
>                                 trace_smb3_tcon_ref(tcon->debug_id, tcon-=
>tc_count,
>                                                     netfs_trace_tcon_ref_=
get_reconnect_server);
>                                 list_add_tail(&tcon->rlist, &tmp_list);
> --
> 2.43.0
>
Please ignore this. I'll send a v2 soon.

--=20
Regards,
Shyam

