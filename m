Return-Path: <stable+bounces-212832-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKNGNoogfGmgKgIAu9opvQ
	(envelope-from <stable+bounces-212832-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 04:07:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 52CC7B6B63
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 04:07:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3EE3F300F16E
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 03:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220DA34679C;
	Fri, 30 Jan 2026 03:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XWxjmgIG"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2743F3446C0
	for <stable@vger.kernel.org>; Fri, 30 Jan 2026 03:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769742471; cv=pass; b=YNh8O5EmVoFACnZpvujSahwYBthVR56HYy2bb4bZ99I3yR225Hst7zD7FN377XflmYGMpthKSM53gLjp4SR22AkW0V1UjDINLbL6yXAzJOS0AkNY0Aiz/GbSSDKROznLV1RwYYJx6ViF5B/k07ZiUBxyJ2I90YqA38ZgGmNpQow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769742471; c=relaxed/simple;
	bh=s/STLv4aZCVQPadjwS93+FSLU3JM9aAkolAS61wE/sg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d2+NPhcQWMFCxVuwZUGf8GInebfUjTmt98Crb18cH76XDnRItuQe05s2WYx0Iyt0ejivXv71gSkX52CQlyY3RzUPpsdaFzLGnJOB0D+/x6cro9BM4wW1eDFdqoD3EH2sYwZgfDvOclD7EUCjZYPgjh/4lRCXhidoRHXTkq6qavw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XWxjmgIG; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2a0834769f0so10755165ad.2
        for <stable@vger.kernel.org>; Thu, 29 Jan 2026 19:07:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769742468; cv=none;
        d=google.com; s=arc-20240605;
        b=gf9EWSi5MwOEL8R9p8arStaLxUqu51hmuiYoqIZeP+JS3I/5LfuxWrtpxcceZzO1HG
         oZu+HuYfyAuSDsARR9dRJGSH/Mhyqtx2ouDAxRifeeW1/zIXIHGLIzavIiTG0B/pBHt4
         FqGnFfnhRYZNucxJqXAjDtbJRx4RiNKQlqtqkOSzGu7TxG57m3cUO3kAsIWZdbVk89ZB
         lE2/Qf9gsdTFIJlDnAhG/jnONi1lG2j72Usy8V+ZpcGIaAQXo42i/CGWAcQadNKSsQJ3
         wvvXlbsFQINav/1h55sNb2zPBoQWYx7ORLyaiDULDSlg62Xqd3hFrIm9h2dmWXSloGbq
         dm7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:dkim-signature;
        bh=l3mlnZZ9VIBVNPrLG6woBCVSdTzsbdrDbnf9ljSQpmA=;
        fh=8z6FHqQuzZZqntRs4k6cxQyKLqt6OqnZsn8BbS2uS+0=;
        b=QuLqmBAM55+jOaQyCHnZbNZnYjIDOHF7PyO43N7TBwIjkk4hoX6leeJPA8akto3tTU
         4zS6c0q3Omu4EcdaEpvA7yUPJEfl2/Y6i96CT1YGpge97jY1Bosb8VmN5Svh2oFkajvT
         jaRhktN7ZFTfFOmtMVTPGPPWGz1XB9HofxhGtF8GgsWi/lbwEDr363km/cjO75bc0nB5
         4DJSf/QeoDAkqn/yvizFsgXbLvxcVkFv9Vlh2V76qhtywcxBDDMFPfARgVAxh/N7xa6s
         RrZHczsTp9OTpeFViSfiAYCpnDOgyee9x731WlB1N2k7AAw+MMaLJP6Qk8We0f9AC/9H
         L2yA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769742468; x=1770347268; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=l3mlnZZ9VIBVNPrLG6woBCVSdTzsbdrDbnf9ljSQpmA=;
        b=XWxjmgIGNtUBTjd3PL1TphWtJWP3h/q2V/mD2tJ3NZ9mdFMuFi2y7XVh6IfcJi8Gg/
         7WPTJ32TVE7g0AsrPw4kxFYkUsFXOkUeAmqb6UjZbla8Wb8VTcDiSoCqRe4KgotbqNOw
         n3b6mk0zsqiIlTsNJLGJuKzEm80AIK3EmYaLXzvV+PHPl+gYc0hUaUCmo1pYAl4J22wI
         scn/E6bt+D3ft+4Y0c8CLe//ExNfYBAMwOBXMwI7LjsNDePOe+x8a8J8a0GmdpTTd4lR
         rkG6zSesXmNs+R1L+hgKC3MCSMckGFfYoIfIsz7VZjKTlnoYDyQDFUyut4jl9Vkc3LF7
         Z/Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769742468; x=1770347268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l3mlnZZ9VIBVNPrLG6woBCVSdTzsbdrDbnf9ljSQpmA=;
        b=pirwQgY2q7amWOacj0+8OySZr6bH7H16dDtrDOImOBUPfJJHpD6DTrkDdJl6ODA01g
         6ywHJcZrUZPN+sunqbn775nhJam00b/1algYsSA871srNYcDYqIp74PnyHYmvUfFjiDa
         kDfch8/5C2Cq2n33JbqLchu4SvjRbScQ5XUbtig1nH3Ks1yB7uK09uV3knwQyZSJTszx
         KjD7WPiHDvio7n9NOauXeEKSMQuv4qlqcV7TJMNbaU9HUN7/VsmjpuOgGaxjDUEOJ4Is
         VwiBb6+OW1O0CmMhDmoabyDqlrTXSrrGHZLlXpN4U2JJixy6yNqa4C+7FHUpH7vWtZBI
         zqzQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8UQLBwFNMwFt8kZYPRWjok3in+tJzVhlgA2ez/bNzSO0Mme3yoqBVmUalkyw4K5oK1Tu0+HY=@vger.kernel.org
X-Gm-Message-State: AOJu0YygtU9wSIswqvhcK54d9KIAaCRkFcVxgNk2LlIam1DXwLizkzAv
	RSg0fhRaZipkOLPtnTiDtCIBMGx3Ei9phzfkRFwuC07JLAHR8zkX1bOJ+UXgOC04vMK5NP8CSVZ
	9M0OxrkFB9UsX319ptZtDUxlaynYkF7Y=
X-Gm-Gg: AZuq6aJ3tml9d1mBA4FTk3z5TBGmwTmIRN4+h96KsT5VgnP1mUwBFa5aJrDXL3zTF6x
	pKVe52s+weYtMjFYwh/leoB8kQQUPq7mkiudvnwZm3E2ef6edXPMXBnhepWgQ/++yMha3W4UziJ
	lwYxGXJ0lQH1SLWcz2bEHQlgaoXvx9NWruECJtvDsovzgmOqKiOKY4UfDJTHbIjqigzgrGE1raR
	LQ+i7qsyDawu9ta5LAH187a7Xzg0Mvz/Yo7x9r4qy64JTELE6rtqRjU+CsSWO/6VxKtXw==
X-Received: by 2002:a17:903:1b67:b0:2a8:dc02:8939 with SMTP id
 d9443c01a7336-2a8dc028b56mr9687905ad.0.1769742467629; Thu, 29 Jan 2026
 19:07:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260129233703.407404-1-xjdeng@buaa.edu.cn> <ie3hipmp5nqappyuwnxm2kpgscnl6qe42cwf2sep4inwunb5th@gontu4foua6q>
In-Reply-To: <ie3hipmp5nqappyuwnxm2kpgscnl6qe42cwf2sep4inwunb5th@gontu4foua6q>
Reply-To: micro6947@gmail.com
From: Xingjing Deng <micro6947@gmail.com>
Date: Fri, 30 Jan 2026 11:07:38 +0800
X-Gm-Features: AZwV_QiqnwM7-hO72ct3vp6624JxKkDGHIKb9BztZJXrs6IyvANn95QXzsWnLaE
Message-ID: <CAK+ZN9oaUh5PPBx5QPCya=hqDM42CQptD2-MrJvMZsypNuZ66A@mail.gmail.com>
Subject: Re: [PATCH v7] misc: fastrpc: check qcom_scm_assign_mem() return in rpmsg_probe
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: srini@kernel.org, amahesh@qti.qualcomm.com, arnd@arndb.de, 
	gregkh@linuxfoundation.org, dri-devel@lists.freedesktop.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Xingjing Deng <xjdeng@buaa.edu.cn>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-212832-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_REPLYTO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[micro6947@gmail.com,stable@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	HAS_REPLYTO(0.00)[micro6947@gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,buaa.edu.cn:email]
X-Rspamd-Queue-Id: 52CC7B6B63
X-Rspamd-Action: no action

Yes, I found that.
I will release patch v8.

Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com> =E4=BA=8E2026=E5=B9=B4=
1=E6=9C=8830=E6=97=A5=E5=91=A8=E4=BA=94 10:38=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, Jan 30, 2026 at 07:37:03AM +0800, Xingjing Deng wrote:
> > In the SDSP probe path, qcom_scm_assign_mem() is used to assign the
> > reserved memory to the configured VMIDs, but its return value was not c=
hecked.
> >
> > Fail the probe if the SCM call fails to avoid continuing with an
> > unexpected/incorrect memory permission configuration.
> >
> > This issue was found by an in-house analysis workflow that extracts AST=
-based
> > information and runs static checks, with LLM assistance for triage, and=
 was
> > confirmed by manual code review.
> > No hardware testing was performed.
> >
> > Fixes: c3c0363bc72d4 ("misc: fastrpc: support complete DMA pool access =
to the DSP")
> > Cc: stable@vger.kernel.org # 6.11-rc1
> > Signed-off-by: Xingjing Deng <xjdeng@buaa.edu.cn>
> > ---
> > v7:
> > - Add the detail description of how the tool detect.
> > - Link to v6: https://lore.kernel.org/linux-arm-msm/20260128033454.2614=
886-1-xjdeng@buaa.edu.cn/
> >
> > v6:
> > - Add description of the detection tool.
> > - Link to v5: https://lore.kernel.org/linux-arm-msm/20260117140351.8755=
11-1-xjdeng@buaa.edu.cn/T/#u
> >
> > v5:
> > - Squash the functional change and indentation fix into a single patch.
> > - Link to v4: https://lore.kernel.org/linux-arm-msm/2026011637-statute-=
showy-2c3f@gregkh/T/#t
> >
> > v4:
> > - Format the indentation
> > - Link to v3: https://lore.kernel.org/linux-arm-msm/20260113084352.72it=
rloj5w7qb5o3@hu-mojha-hyd.qualcomm.com/T/#t
> >
> > v3:
> > - Add missing linux-kernel@vger.kernel.org to cc list.
> > - Standarlize changelog placement/format.
> > - Link to v2: https://lore.kernel.org/linux-arm-msm/20260113063618.e2ke=
47gy3hnfi67e@hu-mojha-hyd.qualcomm.com/T/#t
> >
> > v2:
> > - Add Fixes: and Cc: stable tags.
> > - Link to v1: https://lore.kernel.org/linux-arm-msm/20260113022550.4029=
635-1-xjdeng@buaa.edu.cn/T/#u
> > ---
> >  drivers/misc/fastrpc.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> > index ee652ef01534..8bac2216cb20 100644
> > --- a/drivers/misc/fastrpc.c
> > +++ b/drivers/misc/fastrpc.c
> > @@ -2337,8 +2337,11 @@ static int fastrpc_rpmsg_probe(struct rpmsg_devi=
ce *rpdev)
> >               if (!err) {
> >                       src_perms =3D BIT(QCOM_SCM_VMID_HLOS);
> >
> > -                     qcom_scm_assign_mem(res.start, resource_size(&res=
), &src_perms,
> > +                     err =3D qcom_scm_assign_mem(res.start, resource_s=
ize(&res), &src_perms,
> >                                   data->vmperms, data->vmcount);
> > +                     if (err) {
> > +                             goto err_free_data;
> > +                     }
>
> I think, checkpatch should warn here about unnecessary braces.
>
> >               }
> >
> >       }
> > --
> > 2.25.1
> >
>
> --
> With best wishes
> Dmitry

