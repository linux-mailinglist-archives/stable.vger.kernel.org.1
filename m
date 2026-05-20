Return-Path: <stable+bounces-250009-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ODYsFfLXDWp44AUAu9opvQ
	(envelope-from <stable+bounces-250009-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:49:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4080591353
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CCF3830CB519
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 15:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80FBD3EFFC2;
	Wed, 20 May 2026 15:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NNwwy7ww"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF72F3ED3CC
	for <stable@vger.kernel.org>; Wed, 20 May 2026 15:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779290017; cv=pass; b=rdQ6qV6brKXgcz1krX0oJwbj8CgFf15v3qyH6p0p21dR5QHTQ4xV4LoHljl3UESc6Ah6rpWLefSY5LdAW4Il4jgAILhNjTkntzev0ON7O6hHdOdDLvsNexWgMceGxRHUVfAqghDZGPsisq16Trz0LngmKfcd82/WbYgwV+QG9sU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779290017; c=relaxed/simple;
	bh=0jDm5atvhHuIxeQV8hGmizmK+8RSolpSQCrjOaP+ltM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=efV5CkLZ+prK11ZHsn4Awp2R/jF15k8jIyswstQk4+dLcwLMzC1VL7ggU+bnS3hii04AHCK1OCABIhbfsdLYRSWMSvy+M85aOm08wz6Behxrfq5DKTzso6CcKVqQvOvGKuAxSxTnPZsJ1FqKh3Ybl+9rt2Fjs1CUbkmvTx24U4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NNwwy7ww; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-671588ab0cfso194a12.1
        for <stable@vger.kernel.org>; Wed, 20 May 2026 08:13:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779290014; cv=none;
        d=google.com; s=arc-20240605;
        b=anuo30tEZbtP80cbBKdT0ZgRzmKhQ7Zw6kTIvFx+Id3+w0lWT2grk84a58VoC2RrrG
         6TVdsJXsNQVoIsPXT+43HhmISdP1VIkuCngaJha9hfvhu5//rqYtGmMS0FdSCbFXVJiU
         XnLt2+nyAd7uBbqYgnMaYMnIV7vcp0qCsQJ5uHZtWB+5xSZtFFBFr6nGfpF4+2amRUQq
         Gcolnq8Jpnmi1zxJj99aCNrVsSfS0V/Ivg/DqkjsRr2pe+9TeSVHdEeuFYRN0zV1UOCp
         /HQk1Han6TT2jfvs7RPDRI9n8gaOMP5fJxK2xdyunMoNPwiokkx8+pcSqChjVxdlOTYU
         qy7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0jDm5atvhHuIxeQV8hGmizmK+8RSolpSQCrjOaP+ltM=;
        fh=Skow1AlgA3ERaEz4iQXdmOy//szbOiOe06hGKlGfZgM=;
        b=UNJo2ki2/8aiHmOpseRk5YXN+pCHZhrhkq8q7PMyftGMBOzPRQvrlcIMfIbPS27JTa
         Cvrml/EECc1VZdPjEPz4syJtzLN2erxc5nEPK0hTdc2A0Qjls+sBYWx8PCqbBWmAybgx
         sBqrsiDvFY98DqK0ybYyYncYCuL+WyYPcIiXTANlgeKzwVBa6E4pZ174wFuBXRdrK52P
         odoQsdjpRlif4QmKfNAOp3IYLcWod0lPHBSxcFB+V3FR6yJfiug0vlhHhSC5N/uq4gs+
         5DGMP0upry3MuFfVYdKxL2h+K9txPE3UqkqPEARRg5gFiaHikZDQg1fVzP3CEOFrZ1xQ
         vomg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779290014; x=1779894814; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0jDm5atvhHuIxeQV8hGmizmK+8RSolpSQCrjOaP+ltM=;
        b=NNwwy7wwTGLcUsVkwQqHdrF3IW3iUaL/vxuavvVb75JyG1RtYIswHA8TnpAOlhzVQP
         /g7l2oLySO2lsPMVbGA1zWQTtpwUVw02dKSdYCcbOzfKwJd5tJg+GWHc3atUQiwOGD82
         Hj32nRwLlhBnC0ZVArD/jwdGsTfk3Ls1p63302HkKADafPUE87zWncdOmgg+8y55QG7L
         ilVZj280NxMa/Bjb5E+2e7eFFwWIcgvtWFHMMIKj0fssGC3Igx5AjxTT4dLr9t2IY0EI
         vXac3SZNj2XiEtCq69tUbnLENzXwMTTF2f9XGzU/JZWr5MiRRnDkTTFGF9npJ9FikOea
         F/Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779290014; x=1779894814;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0jDm5atvhHuIxeQV8hGmizmK+8RSolpSQCrjOaP+ltM=;
        b=RmYuz4hl/pvqGwyRllUSkc2VxPcgSrS06gFSTFLb4mc5GUWTOt6TFxYRQ/2/+IUvlE
         CCSmJNTURZYQnSq3KjsQD4vCtrqXnzholk+cfnk43QdrZVPRm8cyHT1OmJWQHzSNbzTN
         9vyAMBpOJwOvUiGnJSzvhcxfL3RUkIIV1rF/anxOCqN6STnmz4hBzGZlXleiyvZm/xm4
         uoH2CzFFyykf2wyUT9xZnmHQyBs9qgEi5RC97K2QeUWD+rzeC8Chd3YjtEo/OmK4x++9
         haSMy8N7nq+w/B9HLUyA9eogS2MyzbUSIvMW3Bi5cRpD6Wleip2dsvaK8pq2WawRxXxr
         T3hQ==
X-Forwarded-Encrypted: i=1; AFNElJ93U3kN9zC3TclRb8pbzoCFYcZAkITE2q2PRri2EhWv0osVuULy81tHuxFC2EY4kutYRdkVVQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmtdGp9LGIbvsZ0+hGeb9i9OLbvtL3ebLbQR5Yq0yO8bEFLQSt
	TxtgoQSijzt0v28QMhcvsqaVRj26ph+QeUaTO2AlGrNIGlB1jthu62aQsLhgH1ue5BGx2V1hGnU
	pnceGnAN4leFk5LvkGsqK1DaRYg4WxD0sOTZJ3kY5
X-Gm-Gg: Acq92OHln3LuRv1r5JfNhYuQfDhDT0oJP7TOYt/MXkbHyY53CD+frlmXRX3A8zMKOJs
	Kv5XrhkoQwW9IA5VKdHmVEWhY6EFryTxl3WBWGwo7uG2P3Ox5ozR7Qmsh8ZfMFSyaa9caP7XDp3
	AuSQqAoNqLrk5yuqK18suWtGBxq2ab30kshBBtKHZcU9GQDuoISx9j8nDaQzl0A4iOhBYzG/u80
	ejWG4KjucZZEhp5IKexPkw9dxe/k0wjr24tuPWkrYhUYAo+agV1ZLrz7KQay4a//E09/kmHyU0q
	3KKfXCvxuy8eJzs=
X-Received: by 2002:a05:6402:52:b0:671:fff6:f82c with SMTP id
 4fb4d7f45d1cf-684891acef2mr234306a12.2.1779290013807; Wed, 20 May 2026
 08:13:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518143233.16091-1-capyenglishlite@gmail.com>
 <20260519212328.GA2614626@google.com> <CAEABq7f3agKZqrBiu+UwXHY44mTcK360ryg-i0w=wEc_Lv+T0A@mail.gmail.com>
In-Reply-To: <CAEABq7f3agKZqrBiu+UwXHY44mTcK360ryg-i0w=wEc_Lv+T0A@mail.gmail.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Wed, 20 May 2026 08:12:57 -0700
X-Gm-Features: AVHnY4L6eZ6JdOCJ4YxM5npWqzTWyTozwWpMd7ccTT89uumPUpXazMBZui-XQ2Y
Message-ID: <CABCJKuej82rrQbQ0eoG+JsY6Fwi0SdVJqduvps7eiPrJ_BgT0A@mail.gmail.com>
Subject: Re: [PATCH v2] module: decompress: check return value of module_extend_max_pages()
To: Afi0 <capyenglishlite@gmail.com>
Cc: linux-modules@vger.kernel.org, chleroy@kernel.org, mcgrof@kernel.org, 
	dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-250009-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[samitolvanen@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: C4080591353
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 19, 2026 at 9:11=E2=80=AFPM Afi0 <capyenglishlite@gmail.com> wr=
ote:
>
> Hi,
>
> You are right, the commit message overstates the impact. The actual resul=
t is an immediate kernel oops, not an OOB write into adjacent slab objects.=
 The fix is still correct - checking the return value avoids the oops. Shal=
l I send a v3 with a corrected commit message?

Yes, please send v3.

Sami

