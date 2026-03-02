Return-Path: <stable+bounces-222610-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OCxWMeebpWmfEwYAu9opvQ
	(envelope-from <stable+bounces-222610-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 15:17:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5FA1DA87C
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 15:17:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 902AD3066BDD
	for <lists+stable@lfdr.de>; Mon,  2 Mar 2026 14:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D353FD135;
	Mon,  2 Mar 2026 14:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bGSgFrx4"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A703A1EE7C6
	for <stable@vger.kernel.org>; Mon,  2 Mar 2026 14:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772460744; cv=pass; b=KlG4/qtmye3q1t7/EPecSEqa0C+lltOKEBXshOYtaeR1CxKdoQjDPSuA+M0eKa9FcgYAhz5dV7DRxZahDA0EjhVray7vXTmIeWNHqGuwXNmR3UMhKEKFoKLITwmBFFKijqW5WXAhgTEB0yLveRzXO86Re2TdGdU5FporlbeqG9s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772460744; c=relaxed/simple;
	bh=7+XBqaJc9bvVC1dxXWlU2g4h3rlH0GcD0qndT9b8LDI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iEejTcVaYmfjvC7N1FEI1S+q5n6oPlfn5gC5XObCeQlUds8WN3Hrlqf8ILSuRAU+zWwLk1YXg5tGLI8pAxv4TGnvVQ4K5VrUidF/w7SkhiI89LtIbfPSnVSsuDwTJzmUyrER6V/M0xVsiNikpnONG4ReuBDq5ocUyFbX84dmpo8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bGSgFrx4; arc=pass smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-12734af2cdcso168093c88.0
        for <stable@vger.kernel.org>; Mon, 02 Mar 2026 06:12:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772460743; cv=none;
        d=google.com; s=arc-20240605;
        b=Zl4KOR89+8xNr7p7wq8xZyTAw5t+6vMS9VwEUYBR5dYvVYL4GdNEnDkAQKsgrUEenf
         0KgloPI+laolve6xgT2+SxytTfPZ3m/G49Gk/WC3oIkT/QHQ9fZC7VoG8c5NOnpWepIV
         l2VT4gkhD/AlA2bgOLbMc8fGhea5gawIAfCrJtBtix7Lt0mr2MpBf4g+Al49cqJwwTx5
         DJ+7lk4yrg29ju4qeWTVr+kNkFY3JIf/Yik4eOUQStlirKPLY0agdEwkuoYN4GHOlyFU
         w33gODPHNqpLhhjttiVPv8UBh76vAo8BdcvvbauH1KQMt+ewzYtB/ia9GzK/hFW0qdTu
         urJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7+XBqaJc9bvVC1dxXWlU2g4h3rlH0GcD0qndT9b8LDI=;
        fh=D3AMo8pmfmi5WWBxb68k7Jw41vJ58MY4HM0/QHxx+94=;
        b=buFGIG2bsjjTs+PucNU5YFDKDmqEgzMsJBd3h9JQf2gFLkMYY9FiV2tU8zhazJrR0N
         Ntniz3REYubuOp2HEw3q4sFlzFXE+xPo2sYVJAjOEvxsUIU30TflX2KzjlF1S9UpwYCb
         4ZW9r3eXDGvLTZywFyzwwY38dCZq7eLhMmEpm7NvJO+CUaDsQbe0ldD1RQWI+IuI9dEE
         QbPaLUMFuz3h4bCL3FgnE2HU0Rgh2on3mFPhO7J/O9RwftXPav6L/FtNWjPa2sQx5oE0
         eVnGVA0qp6YjCwi8wZ4UVRFC4RfUt2GcNDaL7IzDdk56HEps5jpfIwZerLEaL59Y+4dM
         84SA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772460743; x=1773065543; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7+XBqaJc9bvVC1dxXWlU2g4h3rlH0GcD0qndT9b8LDI=;
        b=bGSgFrx4C3WgXP59aj+AIUSmf1J/htRo3lO1gRc6DiIEKGHDKVwrW17M+2B8qDclaT
         ZNy9vDrI/1hFXCBYp7/dXSrmquJZryfi5ZGlujBQQ9f4bvXXYed223HNlbMBNv+Z2b1V
         jDI7gHpMriy64GOWF52Hvp764X0Aq/4/mpokllMMeP82L8571ThO+R0y1g7TnA1W8hd/
         df7TzdGT/qyzMgejKHcQQ+WIsDSghoMXDfwpzt6FG2rUB7Guapkij5bDYKzyIJAej7tX
         l/3bYCpItUEmBX9b0ipPHrZmv2ZfOpE5jOCUeEwR0lYhrJ9vcI+bK0XllFX4tgvO/7AY
         NwmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772460743; x=1773065543;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7+XBqaJc9bvVC1dxXWlU2g4h3rlH0GcD0qndT9b8LDI=;
        b=Gy5le2M1LtFgQyLdFVsTOTS1UNkh0bsi1I+zzzXWWD0+sSnBZ7YabDcuroNWUO9Y4P
         QIQLZpDvBq9hL0szNPD1VLlMNOCO5EZ9uhfEZ2nscy0iAhg7beyEv2wJnAeSuW5ie9bF
         I0S+f6ZgXlyvJ2JNNfVuBD7bxQPe5x9jtT+jgNSa8vRT6hpt3sGCgFpHVITEourkVAsE
         TGA7ZNu4dV5M4yx85s87OvOYwAxkvdhnX2kn9xu0pUZC7ZqTI4dODzAeH6DXT3555s9z
         x+YateRlvP99j8oVj/267zpsdJs7ZBxR/7b+oO0u1SHjAnVxLSt+V61OywfWu4uAPEbe
         bqlQ==
X-Forwarded-Encrypted: i=1; AJvYcCWeGpTBoAOk41uGnEWmFV5b3lhZdwuQgZ8xVuahtxkV5kvUiwf04DzB0ptMvi05AZRI6GormMk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCX9ySQndEk0HgR8n/o85WnughmfzZtOKT0xluvHHRp5Z5MAWK
	UNuMmFF4R4nivEJgtgEpT17OV9ym4MIZMJyNUQL/dhkuLsrigWOSqVBfm0xQLxwBQXNOQ2E7dfm
	A/epALb/BVmRWyKptI0EM/FCWz6WlFfc=
X-Gm-Gg: ATEYQzxomYQYdi6hbqCUP8E8BWQSY/r0Yzu839M/TNCrZr3qe3qR5g483ik4zOLVEth
	AIlNIGd8MQKAbGlsbwFonSux0LRo03mgi+BHIWdHhqObd+3dY8/Lip4ltS5HxoHynnO0279W4bF
	GicNosMxXm2Ow06GzSw9LDochXDnM+QghPWKcN40llj8DShIQChKC96+wd+meHLaV4xCNB9EGvM
	aQqPdiEOVsPLiUcCwa9X+dX3nBNYeJcGnqDB34dtodeNfgM3t+lhcYmjr9pyZF0tpgIqyMuyQC2
	YluPQMfqM3B8T3eRkhnBSnE0HmWnSeNT5GJWz9IeE9EAjSyaTuMqTCBJPH3uP5VsGspHUxYxfpE
	wJFM7abIpALwAD1FbsIS2hsGrF6Eb
X-Received: by 2002:a05:7301:1e96:b0:2b7:f145:a70 with SMTP id
 5a478bee46e88-2bde1b35524mr2731859eec.1.1772460742625; Mon, 02 Mar 2026
 06:12:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANiq72mESZc2RfL2_5wt=LEg6M_7TZ__uELZ2tN=XGwB5Md_vg@mail.gmail.com>
 <aaWZQ5JG4ndWDxov@laps> <CANiq72=4B_HrbO8+U3UR8wS-5eC43=ZqF-=aq48Kg_LEJxMUaw@mail.gmail.com>
In-Reply-To: <CANiq72=4B_HrbO8+U3UR8wS-5eC43=ZqF-=aq48Kg_LEJxMUaw@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 2 Mar 2026 15:12:09 +0100
X-Gm-Features: AaiRm50pZqipurRFP5mCZYearhIVqq3_X3zcOq4MZq5TGJ_m0qO63LesPxvaUlk
Message-ID: <CANiq72nPMXMRWxoA9MVTi-eMQMo3G9sNcD7NtF9f=NL-6oszJA@mail.gmail.com>
Subject: Re: Consider applying patch to 6.12.y
To: Sasha Levin <sashal@kernel.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222610-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miguelojedasandonis@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2D5FA1DA87C
X-Rspamd-Action: no action

On Mon, Mar 2, 2026 at 3:10=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> Taking a quick look, I see others also
> reported the strange FAILED: emails.

i.e. at least I hope it helped to raise the alarm, though I guess I
should have checked first that others already complained to avoid
spamming you :)

Cheers,
Miguel

