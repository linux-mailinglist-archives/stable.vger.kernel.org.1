Return-Path: <stable+bounces-254651-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4GEQMBw+F2qg9wcAu9opvQ
	(envelope-from <stable+bounces-254651-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 20:55:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A9785E942B
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 20:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 029763010C0D
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 18:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AEB03264F2;
	Wed, 27 May 2026 18:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YK9vzTKG";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="LE+QzrIB"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9353242DF
	for <stable@vger.kernel.org>; Wed, 27 May 2026 18:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779908114; cv=pass; b=om2tK4QsyLt8aC41fIBPptAzykRvAQC7se51UWvrTDHw7dRkecnp5DMiuhtLAGDv/aHiugoEz10y/LApk2eAKIKMBvUvkfrTkzF6YozrJq6F41sh719o3Az2oqT7IKpmtEMMf8cUSpvOAnv949SeUuRLCs8cGkAMY0EIF/JhOPQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779908114; c=relaxed/simple;
	bh=IEvaCbrp90Uf04KX7dpNjuPekj4S8vjDGVIGWaoyKRM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jjUGqs/74+4lTZyqZ1It+/+53Y7pGo1EPFFzE4DfhrrHIBan74xrHrcGg2VgwJ7HlStg87Fq8PYBbCg0SKnFjnddITQxrR+euiY/xVwnN1nHUhOIpITPbxlhCZPoijyO04EZIRvhV2RPwRqBN5CY6EP5yZUtV3y4zwIYml1iFf8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YK9vzTKG; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=LE+QzrIB; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779908112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MLY0TfC/baJTb3mL9UQxHNeKvpo2w8hu1Cn5RYQK7KM=;
	b=YK9vzTKG+Wf+q46f5Vz6fLccNqlOm4P4shKXDrk2CvEviV013Q3KzOYDU5s0UYod8yV2BU
	jiQn9t2vuH4TKrl6kravV+ahxQn/lNS86BqM9tfKfBdKKsyhjfTNklRS8Rc41/vHkVz81V
	aujhXMw3O/MR/SlCIuUFTNOchH4sVwE=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-tcXWLatAM-6s8VpkZ7xsHg-1; Wed, 27 May 2026 14:55:09 -0400
X-MC-Unique: tcXWLatAM-6s8VpkZ7xsHg-1
X-Mimecast-MFC-AGG-ID: tcXWLatAM-6s8VpkZ7xsHg_1779908108
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-bd41a598d55so23116766b.1
        for <stable@vger.kernel.org>; Wed, 27 May 2026 11:55:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779908108; cv=none;
        d=google.com; s=arc-20240605;
        b=FQMIkH834WSV/IS9OmmVco+KZx9N0FQ/y2pCbtsKvvhplKbeKZAazKH8+LvjUXLRou
         L1giOiagAgMMz2WECLqxDrr9tkZXI15fRdbgSQD3Q/tiPo1BHLaghfA2aAaiFAZelIeD
         /57FwbMINSpvmsiDwyubn7NhoEkQa8e8T7a1vdhfqJpIFnVTRdwI1sM7cRT0DLE3q0ii
         jz6Y7flzEtLjJAQHLf7o8HD8yuiLxlWQMn1pzX3Y0jUQCKeHDVZYr+8eqBmm6uDlB2Cy
         pFwRL/LZ4gzfzkTI0uzUYiJr7PN4JBLPdEZng6Ifcaut537dzPsM6RAlTqLqwPqK4NQU
         PBkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MLY0TfC/baJTb3mL9UQxHNeKvpo2w8hu1Cn5RYQK7KM=;
        fh=Eo9+D8j/GDQ+yOxcMxBJn7CKtG3eMtENUOVWGm0LhvU=;
        b=DI9lJOt+DMQd/ncOzlEK90W9jYKu5GOA/c85LCUdiUGHoR5nkg0qIg+0xnepl5MO1q
         FwtAhqoGU7EVdS4qNcjmQpbJ5Ij+v4jQpQrabiWFXKHJM2vml9Ck95EFctafUdQbsa0U
         BFNh5+GFVVfkvIhIjtt0kbfwrU1wtX1KhdnF8CCAdV1HMyS4oLUpq3MPhsgHtJBqg2Ii
         n0MeYlLjNo6ZE9mdPte2oF7euYyCH2qko6FNT63bJnKaAjoicBLdUfgV1cXW7pTobK/u
         XcdtYa+2F6jsbnNCWB1uM2czByjpL8Dilyl1P9oNU9yBOSFRRSEGTnJDTn+VW6kkGdu4
         1r6g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779908108; x=1780512908; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MLY0TfC/baJTb3mL9UQxHNeKvpo2w8hu1Cn5RYQK7KM=;
        b=LE+QzrIBBK4T+irObQN5rRCfqd/Cvh/Pm+ER6LasvhpY9J7JZl6yn7bO+uruOf+s61
         BB1Yntt33WGMRTTnRQdK/b4aQ4GNIbm+UBE1gcm6mzAmPDBo8ZlMl+bjDAZifEjRjtaD
         uyBw57B2kwyu/nVIGPy+aCA1edEkKOyYKOSujP5WDAoMb9pOOKqcDmG2OGe0M/B73PY7
         Y21KMWIv1eNheEIcDvWGSgpGonvisUP/eQ/HERzJItre6BISaLEPJrG5bInJxUdGvjL8
         JQcKL4unOr9vVhGs9a2q1VL3hI1S3p7VIXhu2JXS8BRsE4XQuoSoa9nY6SCWXJr6hr2f
         jmAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779908108; x=1780512908;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MLY0TfC/baJTb3mL9UQxHNeKvpo2w8hu1Cn5RYQK7KM=;
        b=ey2f3Ez+dDIIxCLVWPdw7CNuKS2GqDp6YcELJPgcVrkwxTz1dHSY1a3aHsDWgWgMsh
         uRW9EBjlqeB9jMWr9Up44Tu+rJ/38A2Q3y2NNHLiQffZKVmNGzaVtO+QrF1zG6YR4So+
         6tIAkmB+O59M4aOPZ+RqUMo8AcaNAs2/Ai4jWGqGmo5aXMGzbrKeogseKdlS462nVMSr
         LRMskBaMYtJugasEHZiFu1ThSnNipeu3SfsMGyq/sNftXC+cpTgKmiFRrg1CAVIdhixf
         MZW/GQpSpl5u1SJINI9LM5BnxwL9MKjtbGcIyJLkPU3e+QKIn5o817Ho9N86Xjgg17Dc
         Gnkw==
X-Forwarded-Encrypted: i=1; AFNElJ/1zgKmaeHq2U17wFubUTcQ/Pueb2pXqDcqi1IWDf+u9hh7MVQqwkvJi9yVyyNRFwE3ELi4wCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNjlTFGeRrm3YczXrQ4/TbRIwuZtnEIdFFbn8NOhoh7RQ7DuRc
	CF27PN0VgurU8mti1GpbS/UqglXZLhuA5FPH/HdWtGXSB0kjBAffFtvgy0L8Ew2+C/fDT1Oykut
	XwaReXVhR/BbOZvHBo0GPQm+idTW+vN28e0a9KC+NuoesiOOumKszuKiaYwD9zX0EjG20tKYwE8
	PUrdpUTgO9UC64VTeij9xRcFH8dzLBSA4qnVul458nQE2CNQ==
X-Gm-Gg: Acq92OFFJrADctufu10+xW9GShOV5mcbs99s5JUsMY4is2WQPtIG+s4zgq2CiyIpnb5
	8Q3GhDS/Rsq5wdhOBdVClZIt9iqewKeAJnFjuxiqqXAhG867c/hdV82PrbWlmXl9ze4+Z6c44Ha
	1E6y0CpJJSJ3J9JBrRABJTrVmgbZMebegKe/VOHlJxvZX2X7jLs3DY9CEZVYTr46cLLCHq4+kkg
	ZvIgTrRGOifNBDxoKqSYZmYmxcLDldR5DXmsNEKuxQAcZt61hcG0nWUlcp0uiQH0LxXJfS5h1qD
	OMQaljVL4RTFgkTVjWGx5zjzhRflfViYmT8=
X-Received: by 2002:a17:907:8691:b0:bd4:8286:466d with SMTP id a640c23a62f3a-bdbffc5fe5cmr1482315966b.12.1779908108443;
        Wed, 27 May 2026 11:55:08 -0700 (PDT)
X-Received: by 2002:a17:907:8691:b0:bd4:8286:466d with SMTP id
 a640c23a62f3a-bdbffc5fe5cmr1482314066b.12.1779908107896; Wed, 27 May 2026
 11:55:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260527-audit-update-macro-stubs-v1-1-8cda8dbdae0a@kernel.org>
In-Reply-To: <20260527-audit-update-macro-stubs-v1-1-8cda8dbdae0a@kernel.org>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Wed, 27 May 2026 15:54:56 -0300
X-Gm-Features: AVHnY4IicZ2HhE2_4kzqvnb7fp4tMV1lwHhRqpfVbTWpEPC95OYW7fSY74-mqTE
Message-ID: <CAABTaaCZD-6_ar-H8iwOka9WgtuqwEt+=umVuc5xsBHwDcnD-Q@mail.gmail.com>
Subject: Re: [PATCH] audit: Update audit_alloc_mark() and audit_dupe_exe()
 CONFIG_AUDITSYSCALL=n stubs
To: Nathan Chancellor <nathan@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>, 
	Waiman Long <longman@redhat.com>, Richard Guy Briggs <rgb@redhat.com>, audit@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254651-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rrobaina@redhat.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 6A9785E942B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 27, 2026 at 2:52=E2=80=AFPM Nathan Chancellor <nathan@kernel.or=
g> wrote:
>
> Commit 84470b80b7b0 ("audit: fix recursive locking deadlock in
> audit_dupe_exe()") added a ctx parameter to audit_alloc_mark() and
> audit_dupe_exe() but did not update the macro stubs used when
> CONFIG_AUDITSYSCALL is not enabled, resulting in a build error for this
> configuration:
>
>   kernel/auditfilter.c: In function 'audit_data_to_entry':
>   kernel/auditfilter.c:592:85: error: macro 'audit_alloc_mark' passed 4 a=
rguments, but takes just 3
>     592 |                         audit_mark =3D audit_alloc_mark(&entry-=
>rule, str, f_val, NULL);
>         |                                                                =
                     ^
>   In file included from kernel/auditfilter.c:23:
>   kernel/audit.h:327:9: note: macro 'audit_alloc_mark' defined here
>     327 | #define audit_alloc_mark(k, p, l) (ERR_PTR(-EINVAL))
>         |         ^~~~~~~~~~~~~~~~
>   kernel/auditfilter.c:592:38: error: 'audit_alloc_mark' undeclared (firs=
t use in this function)
>     592 |                         audit_mark =3D audit_alloc_mark(&entry-=
>rule, str, f_val, NULL);
>         |                                      ^~~~~~~~~~~~~~~~
>   kernel/auditfilter.c:592:38: note: 'audit_alloc_mark' is a function-lik=
e macro and might be used incorrectly
>   kernel/auditfilter.c:592:38: note: each undeclared identifier is report=
ed only once for each function it appears in
>   kernel/auditfilter.c: In function 'audit_dupe_rule':
>   kernel/auditfilter.c:879:59: error: macro 'audit_dupe_exe' passed 3 arg=
uments, but takes just 2
>     879 |                         err =3D audit_dupe_exe(new, old, ctx);
>         |                                                           ^
>   kernel/audit.h:333:9: note: macro 'audit_dupe_exe' defined here
>     333 | #define audit_dupe_exe(n, o) (-EINVAL)
>         |         ^~~~~~~~~~~~~~
>   kernel/auditfilter.c:879:31: error: 'audit_dupe_exe' undeclared (first =
use in this function)
>     879 |                         err =3D audit_dupe_exe(new, old, ctx);
>         |                               ^~~~~~~~~~~~~~
>   kernel/auditfilter.c:879:31: note: 'audit_dupe_exe' is a function-like =
macro and might be used incorrectly
>
> Update the macros with the correct number of parameters to resolve the
> build error.
>
> Cc: stable@vger.kernel.org
> Fixes: 84470b80b7b0 ("audit: fix recursive locking deadlock in audit_dupe=
_exe()")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  kernel/audit.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/audit.h b/kernel/audit.h
> index f1a77aef4533..92d5e723d570 100644
> --- a/kernel/audit.h
> +++ b/kernel/audit.h
> @@ -324,13 +324,13 @@ extern struct list_head *audit_killed_trees(void);
>  #define audit_watch_path(w) ""
>  #define audit_watch_compare(w, i, d) 0
>
> -#define audit_alloc_mark(k, p, l) (ERR_PTR(-EINVAL))
> +#define audit_alloc_mark(k, p, l, c) (ERR_PTR(-EINVAL))
>  #define audit_mark_path(m) ""
>  #define audit_remove_mark(m) do { } while (0)
>  #define audit_remove_mark_rule(k) do { } while (0)
>  #define audit_mark_compare(m, i, d) 0
>  #define audit_exe_compare(t, m) (-EINVAL)
> -#define audit_dupe_exe(n, o) (-EINVAL)
> +#define audit_dupe_exe(n, o, c) (-EINVAL)
>
>  #define audit_remove_tree_rule(rule) BUG()
>  #define audit_add_tree_rule(rule) -EINVAL
>
> ---
> base-commit: 82bc8394b1aa74aedb9827da7730cfa6639716fd
> change-id: 20260527-audit-update-macro-stubs-6e4d8e8a826e
>
> Best regards,
> --
> Cheers,
> Nathan
>

Hi Nathan,

Good catch, I did miss that! Looks good to me, thanks for fixing it.

Acked-by: Ricardo Robaina <rrobaina@redhat.com>

-Ricardo


