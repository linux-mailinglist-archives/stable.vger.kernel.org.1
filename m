Return-Path: <stable+bounces-235503-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJcGJbIH2GkJWggAu9opvQ
	(envelope-from <stable+bounces-235503-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 22:10:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 02AEA3CF368
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 22:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 36D2B301A91E
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 20:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385883346B4;
	Thu,  9 Apr 2026 20:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mIu/X/TR"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510132E4247
	for <stable@vger.kernel.org>; Thu,  9 Apr 2026 20:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775765408; cv=pass; b=kjyBPo2SOx0yW3rU4o2WZCgx7G91AyoOc9R1AblRIFwOayNrV36mDIf7LfZEwFBEF0rPUb/pmsYFwzr/dJ0c6u0JP+IFmv/6G18aUbTVrrxVvomNALCJMP6oyd4quRQVTg0GOzAMVt8jni8UYPeY/NXlsZxswzkbmi1fZCqflkE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775765408; c=relaxed/simple;
	bh=Q9ffF1K0u2BSHORopMgTiRBjDBVlRUO0JdIH+0s/vb4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=POv/6E3g8D85KxYKgl3GzBZJ8zKJsnab4DwX3G0Q0UXC+bbjdCD33rJM7iDUMQC69WjP4/gZ3bxpnjDXAy/ITh19rTenlRqyDhkTgsR95iOKBi9JXbGf/5eIINx0D4hJPPwnXg/SBJP0XnU5AE07LireWS8I+F4uQotWYCK7OUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mIu/X/TR; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-50d8c7a393fso768681cf.1
        for <stable@vger.kernel.org>; Thu, 09 Apr 2026 13:10:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775765404; cv=none;
        d=google.com; s=arc-20240605;
        b=Gzyz8PLjRA0TaFw3nMfhLYkkrj9wvVna0ag/h48DgQ4TtOn00+XSBNlXGSyQwDCBhv
         FhLoCVKmO649lIMo91PPL0D2gjsekE8zroDrslW+/Zk2fby5MJD24AOtHG3jNgfDyGxC
         /t0hvBmg/9lmPjQykoAKgunAccSkMLYUuMRT6ia0myA9vG39lfTKRwa4xmtpCbMf+G+5
         /rZzbc4cd5y7Kt0eBxK7OVCdHZmyTotxiAlpyWaoYSNQFe0ZU5pNMgYWjK2Z6glhc0OZ
         BXjJpTCgmc7hf8wTqHKZmIGgLbn5qDifjteIEyjUiAUM2ryaZexz3FfXhXPzNKUQVnFq
         Qgsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ew9YJVqzCV0p3Lp1Qxmpt1qcifyX/ZWozjm6bnofDwU=;
        fh=T3c5dRgMaBwxl+akQoAhXTq+cckHbw7EHliSw5v+WMM=;
        b=ZwvYuvDWaGSULSndk6JMueqCMeQaejMca0roTEXbzvGeVrsc5EQx2d92DzWBVlq6Ql
         yxiS4Dd0Zs26tuUZuQAidX3Ezoj7EcKJQ1v4tRaSdjqGGC2aNZ4wdSddEMbN730WncV6
         9R9r8DwCn0VlD6gKa+vpWSUGRGydCl+Q+6HZx7+mjmnR3e+xmhqEplDQRdj6+urcQVJZ
         mBCt4mtOJOWnNuFpi9F2BMy5z/aZcJAPvfolap8FhEpAPy8ap1Y4GNBp+azaGLdTBx1F
         AhVr0J0F2p6UGFCjG+A0pewGKwehOMqg8efDrkQgOIDlTSUbbnEql5NSfVqAYLOJnASI
         32SA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775765404; x=1776370204; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ew9YJVqzCV0p3Lp1Qxmpt1qcifyX/ZWozjm6bnofDwU=;
        b=mIu/X/TRcwJKsEtDfio4KRXFDDoqeEbleakapEeItlqMdftlyjPCibESldqPW7aqpb
         QRRYet5KPzZX4Ac6dbdnHQt7sibnHwoCIx55Cb7qu8sTeb6hM8pUMR7rJbAsbuK7R3cg
         Z+vZO+JlzlAXb+O8D+MV+T1eXudcrUDq/kXwoxQmkTYY/qVYXY840pjrXXekSPO/O3w4
         8wLPQ2WrxGc1PvJIamusNhWqzqqW+j796x/xOwuLsMH2rgNvgNUjm/h5RDhmLEtJ0nAu
         XTmeYEzc2enNs0wzFs5e/Hp4smaz19qWxtTW7ySQR0schZe15YXsLRjCYA5RMyShbXi/
         qrRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775765404; x=1776370204;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ew9YJVqzCV0p3Lp1Qxmpt1qcifyX/ZWozjm6bnofDwU=;
        b=HKBiHaaoDrpVngkjMiiRS7eIqW/bGtQvj5gCYi1y05nfZik/2P/CK/f9maTdMDAh1N
         05XjX9LTuNb8ucxJlwcCjKLCllrs17MK62CNmXJdRQOBjNjDT7g2UdapWSKcXc1BwuCt
         XRVi00q1E1N2l/rTBQEbN3rlTn2taKFaPDNF4NxTR904teKbsRXqz2AkhzVLuk7taP73
         dvEKeJuD/wErTB1lptdxu5Zifz9D6QrS5ik9gxvA3X5PBeYK7H/XplE1PqS4hqA5ciRr
         1I5GuSKnZvUP5Pq3lDTXFP39vOCWQyHLiu4VoBb6bn1JMwNsWid6081AOCnXDzayBRx/
         6+xw==
X-Forwarded-Encrypted: i=1; AJvYcCXm4iwjKmhvD0iUbvZXcS7FAQub7wSoTqEMngSwM1d+u5NKsdQFD6Z/sKC/4zhcJIzUTEkZ5IM=@vger.kernel.org
X-Gm-Message-State: AOJu0YztjtxyXoiAQ9WlGlTU6SGSraCK/CctPmit1vQFQR6ijzDh9Rtj
	5pCYafLZhvFGwtntRVUhqweBl2PZCVy+oWkYrWmy9Z5IAAFOPLt90G/bbFAyMPhHviJte0+y95A
	i6shd6oGx3ByKVGy94MqdUkLkbFMMn0zuJPP/vhz/
X-Gm-Gg: AeBDieu27jm8DaZTxHY7QjHW8rjX1MSCgBuMYQiLj+tEI3JCYcg8PDRLiaK8iP6BD6R
	xTVctQe7bih7WhMG7u6N3BvlGNMgZ3gfUQiShhH9YYGc3ILw33D69fC52HJittlZnKgLPdcF4mn
	VHX3zxAjGNXo3rzbkfb0d0hHD//INx5V0Ep4rz19kjdPe99K+iEZLvH6e28t1wMXmuU02vKBGJK
	5IlAnibM8Jry64CzvF7Gt6F2+xO+R8X9GnAfGstY/0RQu0nLiSIsK9ds0CIVHiu62WOGV7xYgew
	tzKG6KpiRril7mSC9JqPrHnOQoeJ5Xdgvb3/84v3m23pz+Y=
X-Received: by 2002:a05:622a:a983:20b0:50d:418a:9770 with SMTP id
 d75a77b69052e-50dc2535cfamr19504341cf.2.1775765403815; Thu, 09 Apr 2026
 13:10:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260409152822.1073083-1-gourry@gourry.net>
In-Reply-To: <20260409152822.1073083-1-gourry@gourry.net>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 9 Apr 2026 13:09:52 -0700
X-Gm-Features: AQROBzB0iy5dDbU7EKphm65HVhCwBsaWZDeae_72XosBjnydaerQSoGW-5lujDA
Message-ID: <CAJuCfpFJ6+OraOT11_bysOZsymk9OB4+C1M_R0UEYgtgXfVA_A@mail.gmail.com>
Subject: Re: [PATCH] userfaultfd: preserve write protection across UFFDIO_MOVE
To: Gregory Price <gourry@gourry.net>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	akpm@linux-foundation.org, rppt@kernel.org, peterx@redhat.com, 
	aarcange@redhat.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235503-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[surenb@google.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gourry.net:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 02AEA3CF368
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 9, 2026 at 8:28=E2=80=AFAM Gregory Price <gourry@gourry.net> wr=
ote:
>
> move_present_ptes() unconditionally makes the destination PTE writable,
> dropping uffd-wp write-protection from the source PTE.
>
> The original intent was to follow mremap() behavior, but mremap()'s
> move_ptes() preserves the source write state unconditionally.
>
> Modify uffd to preserve the source write state and check the uffd-wp
> condition of the source before setting writable on the destination.
>
> Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gregory Price <gourry@gourry.net>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  mm/userfaultfd.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index e6dfd5f28acd..783ca68aed88 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -1123,7 +1123,10 @@ static long move_present_ptes(struct mm_struct *mm=
,
>                         orig_dst_pte =3D pte_mksoft_dirty(orig_dst_pte);
>                 if (pte_dirty(orig_src_pte))
>                         orig_dst_pte =3D pte_mkdirty(orig_dst_pte);
> -               orig_dst_pte =3D pte_mkwrite(orig_dst_pte, dst_vma);
> +               if (pte_write(orig_src_pte))
> +                       orig_dst_pte =3D pte_mkwrite(orig_dst_pte, dst_vm=
a);
> +               if (pte_uffd_wp(orig_src_pte))
> +                       orig_dst_pte =3D pte_mkuffd_wp(orig_dst_pte);
>                 set_pte_at(mm, dst_addr, dst_pte, orig_dst_pte);
>
>                 src_addr +=3D PAGE_SIZE;
> --
> 2.52.0
>

