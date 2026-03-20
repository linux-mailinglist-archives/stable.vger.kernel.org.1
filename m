Return-Path: <stable+bounces-227450-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CMfVN636vGmd5AIAu9opvQ
	(envelope-from <stable+bounces-227450-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 08:43:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 83FA82D6BCD
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 08:43:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C9B9E3015A6E
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 07:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5493C346AF0;
	Fri, 20 Mar 2026 07:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D7jkzBdX"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E697327FD51
	for <stable@vger.kernel.org>; Fri, 20 Mar 2026 07:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773992616; cv=pass; b=JHKXEDtCDJjzwA2nsFHS3z7KFs1S5PhGDNgQmdhkdWCMEEn2dNkF8fun/FIHUttnFnesz6BEbnacVID4Z5lZmQvm30+WIDrtgPi+xqx7Mep6eGx5PiXeBe6JorcNaCQaO2SFjUsezG72XTvipRiYLBzZ5RwnJUSr8ecRZyGFbw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773992616; c=relaxed/simple;
	bh=RlOnalncJRXIlyYuLKjmVtEW17H7itzj7J5Hhw9r4v4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LEcQCg3NsA1PNXwCGYZ/UgfwmL2cU9hucODUn/n5317JN2Y/RRXiPZ0qeShKoRHUSkFqc47Yc74ZJRhPFMwiW+X5voqk4NlJ64Jq/0TiGPZEyTWfMVtA31VcKQEI1ZR+ZWdMWSNlRQuqbVNgDingZPWJPqPIAa87MNGC3XhoOp4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D7jkzBdX; arc=pass smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b932fe2e1a7so213711266b.1
        for <stable@vger.kernel.org>; Fri, 20 Mar 2026 00:43:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773992613; cv=none;
        d=google.com; s=arc-20240605;
        b=FPN9Mu3JwQ0QWzlY4lkcFcaJl93MaaQNAnTdnPwdmH2bxOpa44f2rJHUxDxrDWyGbh
         GQZHAuk9jdZRFRvT05Cjn2iVe//HbhkHRkL1v/+Ih+yyBMQbxw4u19PZes/pczQ0T7oe
         zZ+ELQxYMKgrorpqIJQqWcKPKKEAAvmgZdiGJ6mD6FL+qvNkIEv17+dW5mHlXmKSSkTm
         PoHdw8rZV8KGHrXC1et6b9lEG9c2E5BIa1WXrIS3gBhOGHeLNB3dhFqAaF42fnBWDch/
         AH5Fb/Azq0I32718z2LwID4bU4LoPl+qTeI07UYKBR6zmeJBiWtm6jgTVpZ4oJH6CcZn
         kWsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZnmAAX0F5BvT7Ekm6/q+ZVK3TkJKOZIX6rvlGFkJP6s=;
        fh=ypyA3VQqMOeG7PEy+dKApWlhhogsRW24ipzBrr2voB0=;
        b=Ih72JA86HrB6mzYymTAXzCiPPs3Ty0+Leb+0kuLzijk6aU6Y4u+lySDtziwEazUi+a
         jfmYRHeAi5Gs/iHLLdv8ggG7DqlvCvpP+VT6BDs8gKFToh5PuON1Ch2Irc1XO2+j5mkz
         OidZF7kD2V3sUGw8MNgqfAiVEn4pC+jvvVhaUewMho3rp+xXIpdV2EwA3qdl01Y/wmkX
         cwKH6ndg25p1sDEwbqr0UD1VvD8G0XYAFdeCAQaDAeKQ0Y1ASHtLc/hJvwTk14qfv5Yq
         YsKJNcBKFoNI0N+XzEXefgsrK4TjpJVhpVT0GOCP13pyR8G61nqvEnMP5DO1zNgdQp48
         YXIQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773992613; x=1774597413; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZnmAAX0F5BvT7Ekm6/q+ZVK3TkJKOZIX6rvlGFkJP6s=;
        b=D7jkzBdXkP3tLzYL4LGjl+OEHNm2ok/lUPkV9AR83y/D21yqUpd4MxLyQTLX4OgB25
         Ub7PVrxT1AXvKO1XqHm7Rk4evgjsi8OK/1TD4/4QYs/aQg4lKOBQGNcBY31TmsIJhocU
         PulzubrCA/HRiMeOqvepV7M4fFLK1AguV7KJrqd3VKBVYE1LRqhDO6o+LrWQkiMkkKRh
         7npzUMqLL4mbBofhWfgpsCLK6GRE3Q5/erfdbBx8siDH1K4nQLJ9+ZUqyJfGMfLVXDP6
         PCLI3d5w2WhPe/Qa84Hu2DqfyrlUARcI7ugiEBagnj9QiFCg6Z1WqTPQWy27C+9rWG5o
         EDtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773992613; x=1774597413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZnmAAX0F5BvT7Ekm6/q+ZVK3TkJKOZIX6rvlGFkJP6s=;
        b=U1LVEzsFgDY1AdxU+sqa3ELN6Hy5RluteILSwFUOkG4kEcdUq9pOjvn0FBPFE3KAYI
         XX6iOCJ97kfNSgtUl7MNnbzEoUphtSVmRXMD+M67g7lwtupPsWwOHoNhAKPO/JomTuyt
         4/P5oHap+UtI/oOie9vujsptzjrq6Cl6gTGfvehXJD2vAjdQwSrkWENHs5dZ/Jp+Vjyh
         UNw5zzVNzd9dalysrkKhPWGFp3QQAKT8Kf/z5Fgd/bNQkTJtIkn4eT0fMu7j8jh9h4bm
         M8jZHGT5HMqHBIms5G5Tu4tbodK6Z3h+8CvTUcaNuVv7j0yn6Y0v3SPH0yDD+n9uAxh1
         oRmg==
X-Forwarded-Encrypted: i=1; AJvYcCWsf/jTvJfIPmd7mWn0PLOYzMiRhd9RooISgWOdJsPRsnnvkuUkT90E+5SrPbwDSCECp48bjuU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzmNx8VXcNcR9oE5HhGy6ivGPefaDIrhDxxJPZjdgckF5C3vc9
	iGnp1R2VqGNo338I5elxDJcQL6hEl6g3l6K3CGaxUaDbgQBjeK/Mgz6LJ/joFvAtbu2odFPEbVr
	IZt7zGk1qh9o/n3zvygE5y/hg6MYM/Tk=
X-Gm-Gg: ATEYQzwuCSVOOvIsb+909/dXzxK1DC0mY1fn50ai4wmBZxK17rqaLXotypQedQ3PMwY
	DRwOQlFguaTX4AOhHY2megqV0XzQ61/bpG6VIx/KWROtu1spXz8Q/LdN9v3owDpAw80eJuCmMq7
	UhZQl179edzONd78fsLjqnQzE3L8kXNAzfMilXCaeK4oLDrFgCZqnUv318LDDRR6c44KTdpsHyZ
	gZo0TjBjXmzL2hK88plqzB0woI8pNDnyNIb+oO7wTVS9N3gZkD5qLhvD+JS7RJlxa43auj/HR8M
	/ybFizgJxu80sxH+CzjzIzBbQZ3nDbai7DcAUDVHhV4jExinBYBj8Bg=
X-Received: by 2002:a17:907:c30f:b0:b98:33a7:d5e3 with SMTP id
 a640c23a62f3a-b9833a7da38mr92239066b.8.1773992612858; Fri, 20 Mar 2026
 00:43:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318075842.3341370-1-gality369@gmail.com> <20260318144509.GA82331@macsyma-wired.lan>
 <CAOmEq9Uq5xMvhT7cyoY2uhSBhwSEEJ1vYRY36N4sxZSPCO1S8w@mail.gmail.com> <20260319135826.GA91368@macsyma-wired.lan>
In-Reply-To: <20260319135826.GA91368@macsyma-wired.lan>
From: ZhengYuan Huang <gality369@gmail.com>
Date: Fri, 20 Mar 2026 15:43:21 +0800
X-Gm-Features: AaiRm50Kae10smYX-Q49h1EZ7iONGnZgBSsOmlgQkjHk0D8vD2D3MhNxlmOLYf0
Message-ID: <CAOmEq9VAW_a7RsSPquy0_eJOLP4aHOWvwTtzmeLUPXpy85xJvw@mail.gmail.com>
Subject: Re: [PATCH] ext4: xattr: fix out-of-bounds access in ext4_xattr_set_entry
To: Theodore Tso <tytso@mit.edu>
Cc: adilger.kernel@dilger.ca, tahsin@google.com, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, baijiaju1990@gmail.com, r33s3n6@gmail.com, 
	zzzccc427@gmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[dilger.ca,google.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-227450-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.920];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gality369@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 83FA82D6BCD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 19, 2026 at 9:59=E2=80=AFPM Theodore Tso <tytso@mit.edu> wrote:
> We don't consider bugs which involve modfying the mounted filesystem
> as valid from a security perspective.  In particular, I don't want to
> add checks to hotpaths to try to protect against these sorts of
> failures, because they simply shouldn't be allowed --- and/or if the
> attacker has write access to the block device while the file system is
> mounted, you've basically lost already.

Thank you for the detailed explanation. I understand that runtime
modifications to a mounted block device are considered out of scope,
and adding checks for such cases in hot paths would be too costly.

Our original understanding was that a filesystem should handle on-disk
inconsistencies gracefully, so we used this approach to simulate
silent disk corruption or I/O errors at runtime and test filesystem
robustness. From your reply above, it seems that this understanding
may not be correct.

> That being said, we are more likely to accept patches to address
> static file system corruption, but the checks need to be done when the
> metadata in question is first loaded, and outside of a hot path.  But
> trying to defend against dynamic modifications of the block device is
> really a fools errand, without completely trashing the performance of
> the file system.

There seem to be three layers of defense: fsck, mount-time checks, and
runtime checks. Would it be more accurate to understand the boundary
this way: once the filesystem metadata has passed mount-time
validation (even if it would not necessarily pass fsck), the
filesystem is still expected to handle later errors gracefully rather
than crash?

More specifically, for inconsistencies that arise at runtime, is the
general expectation that they are outside the filesystem's
responsibility and should instead be handled by other layers (for
example, lower-level storage redundancy / RAID)? Or is there still
room for defensive checks in the filesystem, as long as they are done
outside hot paths?

Thanks again for your time and clarification.

Best regards,
ZhengYuan Huang

