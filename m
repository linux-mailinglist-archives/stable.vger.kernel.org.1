Return-Path: <stable+bounces-254693-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0VJcCyx+F2phHAgAu9opvQ
	(envelope-from <stable+bounces-254693-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 01:28:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA7B5EAECB
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 01:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 43B0930492BB
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 23:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954F23CAE66;
	Wed, 27 May 2026 23:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="IrtiuyKO"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF7B313E38
	for <stable@vger.kernel.org>; Wed, 27 May 2026 23:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779924507; cv=pass; b=T3/eGr4OfzZ5L4B538kBVplpLPAA+jdGogIXizzArgNR7AVRpf+tF18re7iHCT/OdDhGQedz/OR1mzSyo70riWWew9aITjVA9xbrTovHd9kcF1WwCuF0dmKqxMIadz28ERvyu5gErnrv5FMDye3vNpDJ2zUYimQygiIXSh242Vc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779924507; c=relaxed/simple;
	bh=KeLU1eDuBZ4CMy/KV2Fb/Ragnxdbp/6GlWpWzvHftg4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SVTXD8VoIAxzaGOyT/gZVuyRmr7QM3ZqPNDKYuQ9tvsw62M+/NQoD/MxQJGUSiJpq3dofDNDXl7NC4XV2X1K5TLY2ZafXka3gkNTnUQthGcDtyM4mON72xtwVghPYmDY/N3I3Ynq2xVfE/Ox5Qy4wNPa5+NqQh0E5/CJk6xo6X4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=IrtiuyKO; arc=pass smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-835386ff122so12339787b3a.3
        for <stable@vger.kernel.org>; Wed, 27 May 2026 16:28:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779924505; cv=none;
        d=google.com; s=arc-20240605;
        b=i6Q2LE6CC9m7yi30BgF1oRBzcDhruZiU6qhhO6p8mQbv2aLvN/e9p2KtOiPKp2zjfl
         txZZFVQYsfdbqWhemUs0j/IHsMqWIYsA68uoQgIRQRMvDQ3iXeyRJxN9qUA64S22BJ6k
         /emym7wkQrE1uZVipqjgdrpvVOeZoXou+9HN+VOIfQtR3N6Th4x9oNDjox2SOMTzRXNY
         5cvNmaGZgA3oUbhX7qm/i79W3LpW1Wa9eGpREPtceVSArk20eiPpUiPRm80RdV/7xYVV
         lrHhMZ2iGsE+4hr+OlCxnEF4OHFUvmr01hPpneLSN2i4CM10v4TaQZUoThUURQ+rK/F+
         KsuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9IYz0hfcBU0H6vORUO3iSoFTkkBWVqB4Qme4LgDNhoU=;
        fh=2X35tKxei2UawUw9moYmFET1Og+xybcGBrXlm3Q3APg=;
        b=ei/QxWy4InisAQgfoZ8r4a2tSHXlZgcl7xahAv7r1wtmRhMG2QFQFyFgH4ygj0Ae1u
         YxEtg6pK63rF7Q+3VRT+KiQYIg7MXQdh0qcpH+BFuBkycjo8ZE0OaHKIhICCdYzDDtC3
         9H7a0t78BxA8ICnG/elwz5MMTkQg/CF8u3kHAh/Is3jU89oUYyXvCU7p3u1T1e38HocN
         ah8DLBZNA4HDFU/0M/BfKW33tkUr+ioVVeTJyrGpQCafdgCaf/L1n+OuYQimancQyNBs
         rLjxcIaBV7G6B+n2fRU31im7VNqWWnONbbHvQau5UdwoaKUj+lHZJ7HaRrbFS6Y4RvXw
         pdkA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1779924505; x=1780529305; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9IYz0hfcBU0H6vORUO3iSoFTkkBWVqB4Qme4LgDNhoU=;
        b=IrtiuyKOaOvr+KBdEOshIRfqxnQHJmBmUfizW9JdKfZyvaAnD04CP+HoGFFjpMztPF
         4tB0tRS3hxQe2BrPAszNxM/3QWL3ixY/9khE3x7RRM990e8XFopwLYaVywvIh6V1vG41
         uph2pH9QWP7gRmvvAlxcQGcqB3cRT+hFQ3d7dekHFkplckxk/oUB7jjaid5Ey5w6uq/X
         PeRHF33c/WNmJ2/gww1Rc3AJONj7A3AVmDW1XzujotazxUu/X0+LFe/0CI07O3dEwZ7k
         V+YdfHwv43UQ/c06z9l+GnZhUOoOqjp4GWDH/ZVQkvyB8hlie6wXp9EiSLdcyyh7nCk2
         DE5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779924505; x=1780529305;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9IYz0hfcBU0H6vORUO3iSoFTkkBWVqB4Qme4LgDNhoU=;
        b=Ip03onK2v5CPlLC4C0vxRiaEUKUMZuCK2FNlGXYr11rD5fFrEiK0+GQtKtGXZbqBS5
         ozPZUpw+pus7/KnLvu/zFYXTqi7k+UhdNwlZZbKi1zS8E2oOUAqVq1CaSLaNvGXF5+qM
         hadMEp7yOaQzHlCxe0bJ9fcM0RusBRtr4eppxLd19WSV/yfolAUjDqQv7wR5vnd7wiW/
         BWG8yvZ9b76A/EhW3fQLjY3sOMctYigcP0nA5qZ8Go4zjN9rPmzzMjxu3pXHL4/AWpuj
         wYOnBhFjld3JQPlqJx7SeCkxWejsehQGHd4VPi0mZP2F1wcdf9RdjbEy0ZnHJkt8XVNM
         h+sw==
X-Forwarded-Encrypted: i=1; AFNElJ/8uYeGXieNT2khJThpLK/r9XbTBvrTefa0fqXReVcrlaSSoghmpWm71arLglD65d6OCeySTbk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKDeinNXrdxDTqUdCFaaOPVPTXahwSV6I9YoAyKJjXdA6TjGxN
	nvR4TV4Xc/tYfXM/OWHprRARJgH/zOpe07+uTZ7oDtinbPJv+/LWlHcBHFJObXugC8ZVe6L7n1x
	65f9ZfL6XddJuzJBAooTV4mqbtfhWbRjyWSmB6Clc
X-Gm-Gg: Acq92OGrsrAesJ1lKDiNefHLV/Lzupu+5sUuQSz0ugOL9UjuxnfH9o9tj5e/jjOBPY3
	CbjJ6pNoLU/T+usk64tkcUXZNF5htY0rX8jUqkVnqtSrkBMIZmJu9BVp2Z+PwWeNoEoBOmdd0B3
	LF0XgyAECRkHzLt8RP92VaG1wCdcOcGFciRrG3tj5x90KigWNmqcxEIgl3BVQlugc5RNmcN+rab
	svbppTyxRfon2BTjs0BhQ3w5UoQRXHKK5il5y/gNy7RWwuBO324DjJ0UVXzwXjFi4/A9U/T3375
	4I2XyrNDYzEhZHG1CQ==
X-Received: by 2002:a05:6a00:3003:b0:82c:d986:e917 with SMTP id
 d2e1a72fcca58-8415f56374bmr24308110b3a.22.1779924504640; Wed, 27 May 2026
 16:28:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260527-audit-update-macro-stubs-v1-1-8cda8dbdae0a@kernel.org>
 <CAABTaaCZD-6_ar-H8iwOka9WgtuqwEt+=umVuc5xsBHwDcnD-Q@mail.gmail.com>
 <CAHC9VhQfci2gE-eD67DbjL21s7tF+rPWa9bdu0Kk5cfW+gz2Xg@mail.gmail.com> <20260527211235.GA3191279@ax162>
In-Reply-To: <20260527211235.GA3191279@ax162>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 27 May 2026 19:28:12 -0400
X-Gm-Features: AVHnY4IPeeXdZwFiJ88nMoe-_KMFC6vUjpp5zZqFoG637xclFnzNbsM-EU0L7fY
Message-ID: <CAHC9VhRYY-TygCSuii-kjJ0q4AQXqkuccdDp2a+zq3tB-qcjMg@mail.gmail.com>
Subject: Re: [PATCH] audit: Update audit_alloc_mark() and audit_dupe_exe()
 CONFIG_AUDITSYSCALL=n stubs
To: Nathan Chancellor <nathan@kernel.org>, Ricardo Robaina <rrobaina@redhat.com>
Cc: Eric Paris <eparis@redhat.com>, Waiman Long <longman@redhat.com>, 
	Richard Guy Briggs <rgb@redhat.com>, audit@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[paul-moore.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[paul-moore.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254693-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[paul-moore.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul@paul-moore.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid]
X-Rspamd-Queue-Id: 6EA7B5EAECB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 27, 2026 at 5:12=E2=80=AFPM Nathan Chancellor <nathan@kernel.or=
g> wrote:
> On Wed, May 27, 2026 at 03:13:06PM -0400, Paul Moore wrote:
> > Do either of you mind if I squash these two patches together in the
> > audit tree?  I would preserve Nathan's sign-off line and add a comment
> > at the end of the commit description about the fix provided by Nathan.
>
> Sure, I have no qualms with this being squashed with a sufficient note
> that I only provided a compile fix up.

Thanks all.  I just squashed the two patches, including Nathan's
sign-off as well as this note at the end of the commit description:

 "P.P.S: With the permission of both Ricardo and Nathan, I've squashed a
  fixup patch from Nathan that addresses a compile time error when
  CONFIG_AUDITSYSCALL=3Dn."

... if either of you has any concerns about this please let me know
and we'll address them.

The patch can be viewed in the audit/dev branch, and at the link below:

https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git/commit/?h=
=3Ddev&id=3D78e3417e5f7c8b25234baadc3875ce7de109bb37

Thanks again everyone!

--=20
paul-moore.com

