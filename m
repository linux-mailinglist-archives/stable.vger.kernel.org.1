Return-Path: <stable+bounces-217613-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yDM+B4IKmWn1PAMAu9opvQ
	(envelope-from <stable+bounces-217613-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 21 Feb 2026 02:29:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7247016BC16
	for <lists+stable@lfdr.de>; Sat, 21 Feb 2026 02:29:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 80BEC300C93F
	for <lists+stable@lfdr.de>; Sat, 21 Feb 2026 01:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C203112DB;
	Sat, 21 Feb 2026 01:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="20v8q1GN"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5432848A1
	for <stable@vger.kernel.org>; Sat, 21 Feb 2026 01:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771637207; cv=pass; b=cTuhfq+He4Bo4t9o1oIZWDsSgnSlhAaJNGaaj8zVr3P2ZicC58KW5LQMoX/NUbjMzkyclKuti120zVXTjMRgmq7ooG3UhZjUzV9mkBXaMczE597HjQNoVzZ5fHC2uLp7vO9g7FQLNSUIVpy1nIQbKkHPMpbLAPZagmofHkRayLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771637207; c=relaxed/simple;
	bh=5STbB+9jrAm7GRwtsFuE1bDTJIqaJAx3LQZhxa6dUXI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E0Ky6lMIRuq7TmwZrSNgq/bnMsVIyn4AOgmVu+oflNtUzE5Ke7T7PGLRtpiWWJxD59dNjl6UzzTi+8fVvYWD6RVJDMUL7NIeVYUkKVFtyXuHYj9fHnjmE/LghzmdjthMh1lU9JnGT1elqDICtRaHbhdAsv68GeDqB/AXua4dy1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=20v8q1GN; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-65a38c42037so4135a12.0
        for <stable@vger.kernel.org>; Fri, 20 Feb 2026 17:26:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771637205; cv=none;
        d=google.com; s=arc-20240605;
        b=YQOc+96QE3ZOZWLIRdi9mATdyjWnyYkV8yZx5dBAdmGA+oFRjK1H7himz8pE+9xV0w
         b/qgxwYiIwzkYy9Ovpsul3fNNjttTQ4gjSzBrx6AQIRnXc1+aVKiUi9jDbEx/X+IxmKc
         xVlFVj+EznEw+dpAQDzNHJVmB386aLxg283Qv1jdVVTNYBWOQo9vJSpCx0vaH3wPP7YX
         2WVwRS9VJE0E+3N8k29cN+DJc86c1KlkIgLTYLSB/B1xzkBUDatQEVzsJJ68iRUc7N7V
         FgPeeInR5rAfVmmEuK0KqgktzwPh1Ak/kQVGHgl7k/LRPIRZGURDsDQe4i/1/CIGuec0
         maFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=poadtCsOT3quegj+rs/rmY8m195Yu4/fVK7Jcv5Z5jM=;
        fh=LNuwbS6+8zhnwv2AAPqMemppK/CV0jUXn5Qss77S9Ss=;
        b=Lcdk5OC2KHwZFCjDibvy1GX+fsHV+jnNJqAC9JWikmBKM00gKpO9THurDLRzQa13Ap
         j36hyZN6KNjh+k3lUOlJfYN+vmjwcVNLHXObtluN4Cgvwo3ScWUHW7Yz4rlC0H5VWVE9
         atxIQGxowu8PwG71sN5HeRfPbjW1t0waaZ2vuXl7onO2StN60r3yCcDt77reqiaAekaV
         aSKkmQZIn4M6El099k+X2F6Jwx7Zn6qliUp5w8ed1JKxrHypq42rv501wgoVV2ptFL03
         ThNiNuOg1s/pD9S/2F11KqwUTjP5PNdmSXCMtfrRxlPmyoQSX0orowzmJ3LSPGXAungC
         TFWw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771637205; x=1772242005; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=poadtCsOT3quegj+rs/rmY8m195Yu4/fVK7Jcv5Z5jM=;
        b=20v8q1GNtMCslXkTZHSAYjbd9CXxaGSF53TxH3b1hlxFv2UUBK1TPBPh5nJMv7rL2N
         ajpqIP98IM5AtBWmmx3/jpT3oXAVSI3cF/UjVYgy7SszdakWGkgd4DX8zmy6QC6JqM4G
         ySaDKJfZ89cO8IzX0CTZPMYusaJ7cI3wGfcePvy9dswNkCr81NueTZlabAEmMPCYcIxW
         NYiJDkGtG645JWG+XkRJnRYe7v6HD4n0aa+fYn5Ct7hGPqQvDkk5Sy7NEHz1/Erdputi
         Mq7wnZ1UqPJzP/bQMSirBFqzQdr48o59Lhi9okIXFNCJKiPDemsePzjTUHxQIn1CiLth
         oPUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771637205; x=1772242005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=poadtCsOT3quegj+rs/rmY8m195Yu4/fVK7Jcv5Z5jM=;
        b=c0qRXEr4ERfdGJWolHxGqty/u+iufMxzlZ4ZrSIJQlz16TzFs/YOT7ljQBMVShPNld
         sRsq12w3oGXyGJbvxQ4kS813LSnCKpwUYkqpnfF0zZJOvM7ThikwKS43VJ1ua6Fji5rq
         PKoJNI3UYoi82u+SQQ0J72z1t9tCgHPaAwXb0uF43qaR+evcxHR4h+IplYT2wLADMKYB
         dC0S4ScJ8e5LZg/Plafw0jfMR8gZF+rea0fwXRMSgol6TqBwrht/lYFXg3Tbcip8CmEg
         xvYkRglBwzZNgexBgPkhHOCq9kLw7QiXXTTBQ/q5NP5lAWkz+yCf4e0UuKmtK2zFMgJV
         TxUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTqb1g2xPO1lhlL3Y5d7MkPufFz8Mj4cKKLQgKLq1flqy03Gk+69uEv1lE8XStwzPKqDTTpW0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxge5qO1rgSYlnxHonbaxTq1evELq7Nsos94b+QdbMu/lDjVACY
	ASGapzVL3Rp9uMSCISLj+x0L5M+UEJZdcYDxPXgs9keK499IgFZ13TCLnnHkGGujjxNB6uTS9S/
	EYyGOyQl8Sq7MFI8CCYAqlPLzvcmD4ST2TVGxLE4k
X-Gm-Gg: AZuq6aJu5JuYt4Vzqa8g7Y6T7Spvzv0RknxGdQaCu64p4um5IK1LPffD3YhLJ2Z0mIE
	7W8HkUjHQxPpqeH8C2DJk06vRZky7K2HqX04XUFJIKwqztI+a6DtbvdfiaCNv5KqHahzFWJjUlf
	9F6W2WNlZ8gbXVEK+BEHag7+NwV5fqNfOgG1kCl5SF9CMi9PJlH8tE9lihmPuW7U2dD1mS2vWwT
	M53nSwXyds9bYJqINnLoZOLwCxH+QEj00x4PlDTV71SQTUPxSU9XNsojKGwKAchzq/6xaNGHPQk
	xpV+8uU=
X-Received: by 2002:aa7:d716:0:b0:658:102c:861c with SMTP id
 4fb4d7f45d1cf-65eb00f4318mr7913a12.15.1771637204581; Fri, 20 Feb 2026
 17:26:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260206190851.860662-1-yosry.ahmed@linux.dev>
 <20260206190851.860662-10-yosry.ahmed@linux.dev> <aZkGlFwWeRx0ZGCV@google.com>
In-Reply-To: <aZkGlFwWeRx0ZGCV@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Fri, 20 Feb 2026 17:26:32 -0800
X-Gm-Features: AaiRm51XnQyqvDWVVss-ng4gy79dOi3ckmiTALNB8rBtcS3UhZ8J-F4t8-ZqhBU
Message-ID: <CALMp9eRRiwou+Ug99mjoy9JwQ9ND6Mrgv-jsBaWsL=r+CxhfWw@mail.gmail.com>
Subject: Re: [PATCH v5 09/26] KVM: nSVM: Call enter_guest_mode() before
 switching to VMCB02
To: Sean Christopherson <seanjc@google.com>
Cc: Yosry Ahmed <yosry.ahmed@linux.dev>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217613-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jmattson@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 7247016BC16
X-Rspamd-Action: no action

On Fri, Feb 20, 2026 at 5:13=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
> LOL, guess what!  Today end's in 'y', which means there's a nSVM bug!  It=
's a
> super minor one though, especially in the broader context, I just happene=
d to
> see it when looking at this patch.
>
> As per 3f6821aa147b ("KVM: x86: Forcibly leave nested if RSM to L2 hits s=
hutdown"),
> shutdown on RSM is suppose to hit L1, not L2.  But if enter_svm_guest_mod=
e() fails,
> svm_leave_smm() bails without leaving guest code.  Syzkaller probably has=
n't found
> the bug because nested_run_pending doesn't get set, but it's still techni=
cally
> wrong.

Whoever came up with CONFIG_KVM_SMM was an absolute genius!

