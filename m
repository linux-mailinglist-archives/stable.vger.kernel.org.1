Return-Path: <stable+bounces-222440-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yHPUCIARpGlcWQUAu9opvQ
	(envelope-from <stable+bounces-222440-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 11:14:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2C91CF0E1
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 11:14:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2D173300D75F
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 10:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0581C3358B6;
	Sun,  1 Mar 2026 10:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AXy6Px63"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C904733509B
	for <stable@vger.kernel.org>; Sun,  1 Mar 2026 10:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772360061; cv=pass; b=ExkhqI1bE1+nh6SDpQF0buEExO7zMJYe4GhnRxL/eow/ZNoHRtYWbNnp1adMeXIiRS+Rrl2/otJqroF2QpMGrssYWdZs3z8wXZJ1kWkJLbG3V/ALi7tNNtUahnZtjHt0bFyU2mGFew+s+hjbMnJbd68Uj6KRoLs8hccJXIxMpSs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772360061; c=relaxed/simple;
	bh=smjjcYEfUfjLt5aZvwFR1rVZbUYeuPTNF6Izj8F2xnw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oc3LdjN6AgRjcT2Si4NqSocdj9ap4d0XJQBmhP8CCZbx9wBQ9631Xlvebbh7s25rMCAcI0/i9Iz6YbWRa7rHViVNoo9P7ixluRRFH7/pb4rhHStWsGD4eifmRfhuFCD9JDu4/9j7rq0wQk6dkfLsAtcJkTikutmAkfTa4zAM/sg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AXy6Px63; arc=pass smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2bd801b40dbso258294eec.0
        for <stable@vger.kernel.org>; Sun, 01 Mar 2026 02:14:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772360060; cv=none;
        d=google.com; s=arc-20240605;
        b=ed88Kz+cddgal9f72hj5yjjesqRYzyQs0lc7ZCOta6fFnxzDoD+BgOkhp1aiEJ0uC6
         HelYbjtH7zxVBH+/F1JTgnHxDge+ynOiJrCep8iazq60PWmVTyfJ0qAcN3uCQGFraHUQ
         dXEZ7ht4Wh6p9u12zVslp7brOKF6ckqvV5wQYHyCaXQgysA2OyNK7xXCOpjfP0ctYAQl
         9TIPZnuecFlma37qWtlrcgC2TEtudQWrVKj3Rg1ohCINoF4cK/KXsYehma8OUgm4iPUt
         Tgt5g1YgPuq9KYVALrEplw9yjSuP4bXRWN4hJjitNcxWpt4gZYGdnL2gd1RoQn1EqapA
         CANg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=smjjcYEfUfjLt5aZvwFR1rVZbUYeuPTNF6Izj8F2xnw=;
        fh=Me4lvb+0TzIoUKsfdx0+5scFQ0m9HX6KbyTr2oLN9FI=;
        b=QO2I+RmuVRwE3El3L0qVb8cA6LseZROPRLDynZ66YYQb2QHmNyBIeYrc66cYawoFND
         9pykAazy6LUXOdYyU0EfG0UAVybjTHKtj2NYnRIbBgnVHRzVxKquEr6V6lngLk8t+lzT
         k9K/jL3Ev0RPVu/xAZryYxgJFNKkaI555OlBoCy5wd3OENZHQRA93PD1Gy53rWzzd1c+
         ST4V9oKTWPPvQmxoNgXo+OK67ZLPK60TVdNRWXdl5j+yT+cOJenLnM6QkpUdhaKJdvFH
         xK2HRXcrQdheggD19sCnGoc2bsg3fA9rO0Y6LlFTCrskdwYkD2bXUJBy3mDEBNzViQW1
         z+uw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772360060; x=1772964860; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=smjjcYEfUfjLt5aZvwFR1rVZbUYeuPTNF6Izj8F2xnw=;
        b=AXy6Px63gNyMukdcWvaP2gy4ok1eM7Sl7yfcTglD7tYJI2DnvbykrKG+NUbVJ5c0kr
         MRQhEHhbQaGFvq6C2eba0qk6noV4Wfy4+4fadPVViJhiMNlfxamxvwg1KiODsZlmVjd+
         noQq2QrjEqoAye9AphtsXQ6S5VOI3jA/ziTP2IHvALTbt6oRvPQXFFwcWP5h2WUBGVap
         5ganQiizwnFe22YNKgR2cuXCR3ilq0XNIJfjUTWCsxrn2qrkNPBeHjLgsKB8RFJ1tmoS
         II0hTsNtknlJdr+EuQXfW7h4U3bxFzXaFzStZ43+4AhfubRjEpocMNxaP7vYtl5uf9Td
         1rJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772360060; x=1772964860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=smjjcYEfUfjLt5aZvwFR1rVZbUYeuPTNF6Izj8F2xnw=;
        b=YDSaXXefFAoWaup5D3DAs61FSP5ddFCTwmjBBvlPaMLZErG9qnj5EhulnYVJx6F84Z
         dAOYme8QEJhknwYXlq0U1uYb2ERgA2a/5OJuR+jmnHDeTejJQlJ+13rLPgnxSs6PxSyi
         wn6ze/xYSY6H13+bOu67FCmUR6rjqhqC0w8igLqfLeNx1U9GiwONZ9R3EFGDeuAUMeTx
         671n4Je11dVyVxs+NUD+Q4mVkeIVbrxmCKR6Iba986HcAT7C7XhrJ6KMD3B2RYBK+bh3
         C4MtuLUOpHhGKH5bzUBwunCAeLIxiwFC12f+GZeir1l343SKwFMWM+6lJbAfitEl87UI
         aTBA==
X-Gm-Message-State: AOJu0Ywko8OalIgpeoC0g3QAH23yoqP1gJ3rMsqzimtDRDdfnQN1IzYn
	6YWWFcg2PeKv0rMhSM1H9ctHQqQqW4LKPG8/EuMXz9pfJCVDBawH15qZCMDgVq4SettFSdLmo1V
	XNbkyTI/scwvV2feCgUCTC1WrQQGPI1g=
X-Gm-Gg: ATEYQzyQGeTSLbZTr3Quz6zeL6+HogjigdCQe+l0nRjwNiWSp532sNkH9OmVvdVwdRc
	Ipa6dD1JmZ7ThUPLjyNiky5S5B+JahQ1eQKns/a2MO7N8UH2fW7I95c4uIaV2kZCtji1Dt1iQUn
	HltU2zsSHsNDb32B5LtbLjUR9m9knqkrtLjhZCMWJxHRnlbXmPdML3lxPurTsmCJyxywitdyzjs
	q7ieF2+SisHhPyCAnZ6Var3HQqj2Os3uSDg8nVj8saAC1+a9l4e8aTjrqx+rHPjj0A3Emf4B/DY
	N920RH6sE/kcnX8Hb0MrJG1itl0PZq8RVYgEeHwMULUZ+yROEU3BbHxP2m2KAIU9gb5dbZAv6r2
	xzw/pFwaDKuelaIlCm5GvbppaRmRP
X-Received: by 2002:a05:7300:fd11:b0:2bd:ceb6:5d16 with SMTP id
 5a478bee46e88-2bde1d153bdmr1650466eec.4.1772360059929; Sun, 01 Mar 2026
 02:14:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260301015502.1722156-1-sashal@kernel.org>
In-Reply-To: <20260301015502.1722156-1-sashal@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 1 Mar 2026 11:14:07 +0100
X-Gm-Features: AaiRm50Fdl0EQs8Iv3zuJ_WNhaCmLslUaEiE8LfKnqF2gKgqEqLKJTYpWaThhHU
Message-ID: <CANiq72nJJKdY8Bfq0Y76vU_fM1Ho+002cT8covjAkRFHk1dU9A@mail.gmail.com>
Subject: Re: FAILED: Patch "rust: kbuild: pass `-Zunstable-options` for Rust
 1.95.0" failed to apply to 5.15-stable tree
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, ojeda@kernel.org, David Wood <david@davidtw.co>, 
	Wesley Wiser <wwiser@gmail.com>, Gary Guo <gary@garyguo.net>, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222440-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,davidtw.co,gmail.com,garyguo.net];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miguelojedasandonis@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BC2C91CF0E1
X-Rspamd-Action: no action

On Sun, Mar 1, 2026 at 2:55=E2=80=AFAM Sasha Levin <sashal@kernel.org> wrot=
e:
>
> The patch below does not apply to the 5.15-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

There is no Rust in 5.15.y, so this is fine:

> Cc: stable@vger.kernel.org # Needed in 6.12.y and later (Rust is pinned i=
n older LTSs).

Cheers,
Miguel

