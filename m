Return-Path: <stable+bounces-230390-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4PlSBaFOxGljyAQAu9opvQ
	(envelope-from <stable+bounces-230390-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 22:07:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 57CC232C293
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 22:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 748F33047A67
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 21:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D891E32F749;
	Wed, 25 Mar 2026 21:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OImVs1zk"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8C832694E
	for <stable@vger.kernel.org>; Wed, 25 Mar 2026 21:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774472855; cv=pass; b=c9bUFVnQ3fTh3sVZMVJMgyuvwKrmIQACgD8sxJq7z+De3bcwAOd8te7rvGNCW0pw7UOxOhHYfZQTHkQHWovYfF5cFLHFqYVM19CYADcuqxUi0ikdvpqSEWm2xtybQe7nf30V/Dmr1a3pkmdoa+KKlItWPO3q0RYSCUt81hgkG9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774472855; c=relaxed/simple;
	bh=JGjs+v5dawp1OwMd2nAirdT8cW4F0CuocDS42X+FnRk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tH9A5H10WsXIu76d+CaEj80B0V1B8oIqHGjXtKk0jwPkFE2QfMe8iqDIujRdjlRc3QI3MIXmtUFSNiwQcl4VBt1Cj7CxcbTvljINiCWIO7tf/gYn01RNmiy5oPcajLzxYJLHInrv5ft7l1e1SdVlUE/nWZCowxmSiKDK23T78RY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OImVs1zk; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-66a33f61d80so461172a12.0
        for <stable@vger.kernel.org>; Wed, 25 Mar 2026 14:07:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774472852; cv=none;
        d=google.com; s=arc-20240605;
        b=EmhRrLU7OPnTdTmxbuhI3RYWvW235IjY4I8T6i9tL95lZYMksG1sXERsmkY3Z7JUA/
         Wuh2K1LoHNA6N4JKpk2HMWifqTlBisABAUCmiNuSNL1z40GPGwV1d4W9kGoU3DkAUvu0
         zQc9N0LBJUqaFDmIUlFJJtB5pm9cM5fow0QVEQkVcRt7hL9891B2/dXaxLtTIoN0OsMq
         IKdh61VrW3kg6tMemVQ6pL4HBkw6WnG42Pv4QT5WfdkIleRLTf5PTLeC7oKyMC7l+NYi
         yWVxwazfwq7Eee7PNGRrNHl5cVhmO7Y21VSMpJjy+QW+k3Qqhc0xgE9eoyeJS9WWAWnT
         MVPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MYHNxKB+bgvczQp1QPu1TdjgicMQ/b36W0rRs4Y4aSg=;
        fh=kRIX7tchUnVuqAxIRiYtObHbm7bi+XhyBAq1faR9b7M=;
        b=R/kzRXhH332heL+pyJdEkDWH/ZGgF2nKJ8V4ZNWOi8BOR4KvKKN0NEBCB31phkkH8c
         FQoM0IxA/2Unl/k8QnFBv6ZGKEo8M6iUXc6Z8cYKQgwMlai91vcjORIT29fCSU2Z9lfz
         tpVcEfrRy1TU3WGCqaC6OboSFTslyWn9Qth9bwD+hqRAsJTOsqfhTkyJlUMroAlMqWiF
         exuIlNGga6zo0JdC+p6mir6ackCk1AlbvQ9Hhn56bg1TweX5am0fNcRgoiJr90pzswNY
         j/fnENBDyT5C9lRELTjs6C5lZGBmzr+gGBhzJxmKAGnvoLwnycX1TD+fPu2L/oJP6zke
         YNXg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774472852; x=1775077652; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MYHNxKB+bgvczQp1QPu1TdjgicMQ/b36W0rRs4Y4aSg=;
        b=OImVs1zkUJrlAkN52OwyfOW0lQFYMTwJf4Aq0gO3e+S/8/zHDfVDOG7htEcM0wVjxS
         7QBcjyYil/fcM56MZvIPoU8ESgiGBASTGxGb0GYVcHRaJ/Yb7GWo63hKC6fSYxx83Nky
         IMAZg9n4IICog16zDUZqs6PM9+B6T4ID8SUXWLDs50vlRwQaayYepSt5SzlQ6ruxnhIh
         MhgnFk4BzJwrYUo7QqlgkVfz/iVGEic1WZ/sVbH8IbyOmaqkZdNoNran00OHGlnmt20L
         2cNTbKeBQrxptXlhbB+Umo6alPQsb1k7KhAUg89JpUOelK3yO89TSz17qzDSrWcLS4Xn
         jjaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774472852; x=1775077652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MYHNxKB+bgvczQp1QPu1TdjgicMQ/b36W0rRs4Y4aSg=;
        b=kemG+Z5ZWuybFbktz1oHc/2q1FerD5HODc6DOyuq1to3VSajr0x318seXLqCOrQMbg
         JV3tM1ypzePOWGW2ig3K51cgrKskHDmJ1mWHuTUPZQeJ9Pf5B2Z4TaTYlgzP/8/LQL+L
         oJCGcpDk8A0pwhCUDSkk4KKKS+vo8I9UcqHdpGkHoYPjSwvWyjxCUgpYfhEzBi62zX+e
         LQSetOBwpymPm1AQBXEefC2sqIEefCQ79GDs5YLLsSunsb5QhRuDMClY1x2VL4JAW9n2
         13ld6zRwk21PycjDL9NN0958T697TBIt3EhBjw8BW9GZ7H2pPq0drO6dyr0u0qTk2qOu
         Apug==
X-Forwarded-Encrypted: i=1; AJvYcCXhDlLrYUE1QV4WYSuoAofzbTN+nmK9EjksCrl1vcG+CljY6lABWqlihc7/0FYVC6h/J4Mc8L8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP9kRd2OmwYoTmQpTFL3rSODJfKYZO/tJhUMjPimMkawOjKShz
	4sBDylLlFawvRxHnxpqsHCmjDMEeewF6/wsFxn06j0l4EJXc+U+xRVBuYkJBSfW5XWVCja16Fbt
	xhyc0WT9ECJfDFBwxTc67iTrTQyw/Icc=
X-Gm-Gg: ATEYQzx2fkZ9RByRBAjllYhDEFtjmM0HGQWr0jxgqIx/0y+AyEHEFKPERoiCyHkMQIh
	Lks9Wbi+6bX7vebyLPO0PmZvj2H/JBEsxSprnz4qI2OKDmd3QbjZM5tDxLcQSesgbp7zIhfmp0y
	nfqMh5BIC+FN5yufz+lfwM6nY9QKNebABL+rKicPmECUL7yWT6ohPMM6R8s9/wjc+ZOTuDXi2kE
	JyshMc5s1Bp+ZCdFbL5X80HZDLGaLWg8POpsmupp3wCRqYQjSgqVgHinaRfL98NsYsPBuM2jfj9
	66agwhX0Fayb5MGFy3gUNkUfsyNluApXLk6s9Mk=
X-Received: by 2002:a05:6402:528d:b0:66a:16ed:46d3 with SMTP id
 4fb4d7f45d1cf-66a826ea687mr3278329a12.30.1774472852230; Wed, 25 Mar 2026
 14:07:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320090428.24899-2-jack@suse.cz>
In-Reply-To: <20260320090428.24899-2-jack@suse.cz>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 25 Mar 2026 22:07:20 +0100
X-Gm-Features: AQROBzBanJ2emY_czit1kyH4Eyo3hZKOPBi6ESjKXPu7BVQXtoaBV59UZf-eTh8
Message-ID: <CAGudoHF8zgjcKiHx75EwPmz5eTp_7yk+dh+ju4Ju2xZJqFJYvw@mail.gmail.com>
Subject: Re: [PATCH] ext4: Fix deadlock on inode reallocation
To: Jan Kara <jack@suse.cz>
Cc: Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org, yi1.lai@linux.intel.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-230390-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mjguzik@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,intel.com:email]
X-Rspamd-Queue-Id: 57CC232C293
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

can this get any traction?

master as-is contains a change which uncovered the ext4 problem.
either the deadlock needs to be fixed in time for the release or the
other change needs to get temporarily reverted.

interested parties can find proposed revert here:
https://lore.kernel.org/linux-fsdevel/20260316103306.1258289-1-mjguzik@gmai=
l.com/

On Fri, Mar 20, 2026 at 10:04=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
>
> Currently there is a race in ext4 when reallocating freed inode
> resulting in a deadlock:
>
> Task1                                   Task2
> ext4_evict_inode()
>   handle =3D ext4_journal_start();
>   ...
>   if (IS_SYNC(inode))
>     handle->h_sync =3D 1;
>   ext4_free_inode()
>                                         ext4_new_inode()
>                                           handle =3D ext4_journal_start()
>                                           finds the bit in inode bitmap
>                                             already clear
>                                           insert_inode_locked()
>                                             waits for inode to be
>                                               removed from the hash.
>   ext4_journal_stop(handle)
>     jbd2_journal_stop(handle)
>       jbd2_log_wait_commit(journal, tid);
>         - deadlocks waiting for transaction handle Task2 holds
>
> Fix the problem by removing inode from the hash already in
> ext4_clear_inode() by which time all IO for the inode is done so reuse
> is already fine but we are still before possibly blocking on transaction
> commit.
>
> Reported-by: "Lai, Yi" <yi1.lai@linux.intel.com>
> Link: https://lore.kernel.org/all/abNvb2PcrKj1FBeC@ly-workstation
> Fixes: 88ec797c4680 ("fs: make insert_inode_locked() wait for inode destr=
uction")
> CC: stable@vger.kernel.org
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  fs/ext4/super.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> Ted, this is a regression recently introduced by VFS changes in
> insert_inode_locked() but I think it's best fixed in ext4. If you agree, =
it
> would be nice to merge this so that it makes it to 7.0 release. Thanks!
>
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 43f680c750ae..b8122d24c083 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -1527,6 +1527,27 @@ void ext4_clear_inode(struct inode *inode)
>         invalidate_inode_buffers(inode);
>         clear_inode(inode);
>         ext4_discard_preallocations(inode);
> +       /*
> +        * We must remove the inode from the hash before ext4_free_inode(=
)
> +        * clears the bit in inode bitmap as otherwise another process re=
using
> +        * the inode will block in insert_inode_hash() waiting for inode
> +        * eviction to complete while holding transaction handle open, bu=
t
> +        * ext4_evict_inode() still running for that inode could block wa=
iting
> +        * for transaction commit if the inode is marked as IS_SYNC =3D> =
deadlock.
> +        *
> +        * Removing the inode from the hash here is safe. There are two c=
ases
> +        * to consider:
> +        * 1) The inode still has references to it (i_nlink > 0). In that=
 case
> +        * we are keeping the inode and once we remove the inode from the=
 hash,
> +        * iget() can create the new inode structure for the same inode n=
umber
> +        * and we are fine with that as all IO on behalf of the inode is
> +        * finished.
> +        * 2) We are deleting the inode (i_nlink =3D=3D 0). In that case =
inode
> +        * number cannot be reused until ext4_free_inode() clears the bit=
 in
> +        * the inode bitmap, at which point all IO is done and reuse is f=
ine
> +        * again.
> +        */
> +       remove_inode_hash(inode);
>         ext4_es_remove_extent(inode, 0, EXT_MAX_BLOCKS);
>         dquot_drop(inode);
>         if (EXT4_I(inode)->jinode) {
> --
> 2.51.0
>

