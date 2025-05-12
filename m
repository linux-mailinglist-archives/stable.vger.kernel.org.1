Return-Path: <stable+bounces-143136-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D459EAB323D
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 10:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8DA53ACD25
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 08:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E0FC25A2AC;
	Mon, 12 May 2025 08:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JblRDqxA"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218342566EE
	for <stable@vger.kernel.org>; Mon, 12 May 2025 08:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747039848; cv=none; b=hjugawAEr1BRO4rLDa8vV8hCedlztHQjzdv9xJbnJsEsvfKSEkDD+S+3Kod75vcik1HVhDhojPa5u+Fh/cVnVURt4M+uNPxctuA1qdoQYN7o3jM5NAgkocO5apeolhcm1UmTcVmOut0rKe8rGpGylPUTq4Gt7tjMCa5N3D+GuKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747039848; c=relaxed/simple;
	bh=4iMobanZvL6ZMqvaDbrkvLN2vR3Q3UVfZ/v9JwDE/rs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CE7Ng+dJwUGssRo60ENNaMk8uT4fjzhMwH4zvFL52vYzZxwhP6buq6KuYFt/l7B7g92yfneZSzqJi804FwxQJgH8nOU/CKfeBR77e9x3S72Zss0l/wyawn+TORU2MIMlSQGqaP+mZ1qEL4zp/4uoBd3GBAq5skNcYy0X7KQDZdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JblRDqxA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747039846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wRVZE0uzDi6mY23fwHxsV0F3g4VaiH2RBigcwGLVHN4=;
	b=JblRDqxAlDfa7Lp/qSzcGq2L0dkQDxvAQZQysX6v+jWAfK2P0Upd8KAYqfAUT1kqfWPKcH
	wUyQafXTFz0BRU83lEfrVmguAh0WbLvuz+6EOjQCGst7+Cl/xa/J83QxP4kYXGaNestTqj
	vVFmxLnTgRdBZuZWBo2/j4yAlE6GiwE=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-464-yb2-VjfjMjyBdVeajXFhww-1; Mon, 12 May 2025 04:50:44 -0400
X-MC-Unique: yb2-VjfjMjyBdVeajXFhww-1
X-Mimecast-MFC-AGG-ID: yb2-VjfjMjyBdVeajXFhww_1747039843
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-acb8f9f58ebso353132266b.2
        for <stable@vger.kernel.org>; Mon, 12 May 2025 01:50:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747039842; x=1747644642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wRVZE0uzDi6mY23fwHxsV0F3g4VaiH2RBigcwGLVHN4=;
        b=XyMfHVpfrt8l4DK/xwBw/O9VL7k4XELIFmorf/8TqLLX/XAu4lX9tE2FnXqe1oabow
         z/a1ahWxVvUEERItacOqfQ0CjLTmE8UVcW/ppSQifFEnzvLy0op3EKbvn+tEV6A2P1IM
         8cqQc+GmPHyADo+hqIlkLR1q8RP4LSUNEKGp6kpu0zqyAtE1p4XCodmMbtJM9e3sYLY1
         7U9l7GHyI6ISuOyaGW0cXZ55CMHtsX8GxxWOWMvW311YVnqaj9qBQ+ZftuH7yKw7vCeA
         3JexF+ilrQrbQwfKwmpNmXIgMiBdKipnsbpZ+peLd/B1La6DtkOYrX3w7YPEf2fotxC+
         b12g==
X-Forwarded-Encrypted: i=1; AJvYcCWvVz9AEERgJk2N/Wrdg7nMrZA+6U2+FOjo/EM8cN4mstelw/lrR+awYRJaG9k8A3ZwTh4XALs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVf18uWu2JRq/sOQceSZj+rvyLyQMjuQ6iQrnn8ZcMJG4wgvh+
	6tuwI9c/pAZPIPsB/azL6NoPloS4rYE83PWrBLpzceILfW7ey4qnZJfaz1R7fqOwOgLit27QwbO
	qujV+4PC0MfHh38iy+UFrUJ+wKQiaOyfZOB3VYRaFY78iHxDDgUdIL6gDpcBYfQ==
X-Gm-Gg: ASbGnctTHHXLF/0IuhjRUcjIRpjKP1EB3OjKu1Sk/Vzqrez0obIzx9acXLHBA8QrFGg
	CxOTz6j12BS7a+wUrXjiI5Rt35hrfUCfGDIcvbD/0wB4JDLUI+uPO+H+dPbTQ7475cLzPWCLbu0
	I60B12zvWJn5fVANurqLWmWpFQFpOwj76hcPVkfCt5cHZzyBNm4HzxZcGTnALpPNm1Xa5N3iUE+
	4eGPPaqKJhVpnOFXHWGQeik/bVz2iLJB/joJx17n88+tBKEyTcinpO2nHOA2oZrc9Q/BtIi0eXz
	VeiczeB0b4Uv8IMpItNzmvv5n0K9rJZl5FcjML1DQ2vhF+Q/7utOKYA=
X-Received: by 2002:a17:907:9628:b0:ad2:3371:55cd with SMTP id a640c23a62f3a-ad233715c99mr713692866b.5.1747039842376;
        Mon, 12 May 2025 01:50:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSljQgiL2cPOQkorag8Y/JJhPj5K70If7rNnfBu/H6fyrDaRWF7KwnU4F2z9lX96I7XNy4Ew==
X-Received: by 2002:a17:907:9628:b0:ad2:3371:55cd with SMTP id a640c23a62f3a-ad233715c99mr713690966b.5.1747039841936;
        Mon, 12 May 2025 01:50:41 -0700 (PDT)
Received: from [172.16.2.76] (5920ab7b.static.cust.trined.nl. [89.32.171.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad219853438sm581896566b.162.2025.05.12.01.50.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 May 2025 01:50:41 -0700 (PDT)
From: Eelco Chaudron <echaudro@redhat.com>
To: gregkh@linuxfoundation.org
Cc: aconole@redhat.com, i.maximets@ovn.org, kuba@kernel.org,
 stable@vger.kernel.org
Subject: Re: FAILED: patch
 "[PATCH] openvswitch: Fix unsafe attribute parsing in" failed to apply to
 5.4-stable tree
Date: Mon, 12 May 2025 10:50:39 +0200
X-Mailer: MailMate (2.0r6255)
Message-ID: <8DD6C6C6-2277-4A95-B73D-E95DB1B2D21C@redhat.com>
In-Reply-To: <2025050913-rubble-confirm-99ee@gregkh>
References: <2025050913-rubble-confirm-99ee@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable



On 9 May 2025, at 10:56, gregkh@linuxfoundation.org wrote:

> The patch below does not apply to the 5.4-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit=

> id to <stable@vger.kernel.org>.

Hi Greg,

I've just sent out a patch using the description below. This is my first =
time doing this, so please let me know if I messed anything up. :)

Cheers,

Eelco


> To reproduce the conflict and resubmit, you may use the following comma=
nds:
>
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.=
git/ linux-5.4.y
> git checkout FETCH_HEAD
> git cherry-pick -x 6beb6835c1fbb3f676aebb51a5fee6b77fed9308
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '202505091=
3-rubble-confirm-99ee@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..
>
> Possible dependencies:
>
>
>
> thanks,
>
> greg k-h
>
> ------------------ original commit in Linus's tree ------------------
>
> From 6beb6835c1fbb3f676aebb51a5fee6b77fed9308 Mon Sep 17 00:00:00 2001
> From: Eelco Chaudron <echaudro@redhat.com>
> Date: Tue, 6 May 2025 16:28:54 +0200
> Subject: [PATCH] openvswitch: Fix unsafe attribute parsing in
>  output_userspace()
>
> This patch replaces the manual Netlink attribute iteration in
> output_userspace() with nla_for_each_nested(), which ensures that only
> well-formed attributes are processed.
>
> Fixes: ccb1352e76cf ("net: Add Open vSwitch kernel components.")
> Signed-off-by: Eelco Chaudron <echaudro@redhat.com>
> Acked-by: Ilya Maximets <i.maximets@ovn.org>
> Acked-by: Aaron Conole <aconole@redhat.com>
> Link: https://patch.msgid.link/0bd65949df61591d9171c0dc13e42cea8941da10=
=2E1746541734.git.echaudro@redhat.com
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>
> diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
> index 61fea7baae5d..2f22ca59586f 100644
> --- a/net/openvswitch/actions.c
> +++ b/net/openvswitch/actions.c
> @@ -975,8 +975,7 @@ static int output_userspace(struct datapath *dp, st=
ruct sk_buff *skb,
>  	upcall.cmd =3D OVS_PACKET_CMD_ACTION;
>  	upcall.mru =3D OVS_CB(skb)->mru;
>
> -	for (a =3D nla_data(attr), rem =3D nla_len(attr); rem > 0;
> -	     a =3D nla_next(a, &rem)) {
> +	nla_for_each_nested(a, attr, rem) {
>  		switch (nla_type(a)) {
>  		case OVS_USERSPACE_ATTR_USERDATA:
>  			upcall.userdata =3D a;


