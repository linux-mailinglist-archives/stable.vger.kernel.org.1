Return-Path: <stable+bounces-217461-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aOu9AnA3l2lfvwIAu9opvQ
	(envelope-from <stable+bounces-217461-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 17:16:48 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 54BDD16090C
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 17:16:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F12953016CBE
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 16:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F06345734;
	Thu, 19 Feb 2026 16:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a8QPnvWQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87759244685
	for <stable@vger.kernel.org>; Thu, 19 Feb 2026 16:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771517787; cv=pass; b=ckT/JPmY/ZKt8sMAY9osKib0Z9d+zwOdyXrrBKaP3oQj2uIztP8R+Kj98l/hBKys6Lc5+BQgRp8GOIAKVZtqjsGyAUZGOjr3Vi6BV+D3ioQUy8efGXhvqrXdngMW8HTjPsC438AvsCp8kit1RJgZaHsDB6tJDgtk3niS3J9sZxI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771517787; c=relaxed/simple;
	bh=zOIRLawsYZ+W3itGuhJxFEilIfJwYHNIHJIzlKHhcaU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h7rc3h63W0DNArFeXw7Cgnw5DZHplpvRZx3ggiDxhZ0D1/6ZBJkGH/XO+Grhval+305fScYb80FMoIxlzM1UaGRxCzGDCPDpRR3L7Cv53HZrBb9S6jWptmWQOZVcS+7T3A7V2AShEXkz9GgbI+Q0rQIM87xLP8x1+5W7J3Rg7b8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a8QPnvWQ; arc=pass smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-64ad019bbd4so1064428d50.0
        for <stable@vger.kernel.org>; Thu, 19 Feb 2026 08:16:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771517785; cv=none;
        d=google.com; s=arc-20240605;
        b=M84MAdiijuNNg8PJqE8gVxrj2q78gqCa6JmTwk6882IaPIj0+5pfd2s1KQoD+orLql
         yfmMDQ7wRLV8XyAtpiJSZ7pAsvt0INo6BqI4rvLwHUpIaGkIRA32SEu0ay+uk95j2QxD
         2hnHLsdGvTZL0ro5MFWCr31GZaXHFF4DiCxRqJVKB+R3JeGzLv7H2C7XgLAzMSuuZu77
         2OV0Oe9TtuBeyXlKPsMaI489ucTBun83z8gxbqnwwhnItmzgyPbbd7MltAoVUFktGD0B
         3l6bvCA67ddj/mQajrxZqd73pb6KOJdkwa/Uvfr4L9Yh+b9mruL/zPxt8bca7m8FpnNf
         5vnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3wg+vKqYtXz46jjz22+jIAy3md1p+mu/01FpEpqGKtQ=;
        fh=CIK1gmM9JwQoKFbCBRc9xWA8d1x8JYtBgo65TzwY1+Y=;
        b=HeKLZvzObUZHUW8bhfqheVrCZG+k6QD7N8bAiq+BSujv98WK5KlKhJly8t/Iv0EIxw
         4H8+gfLy26FI80RZnuEfwrUeiansxa0QQxYWU/qbi6s0GY+g81k7lanubTq8YshOFyz4
         dNT7CUW1DcZ0w4TMZMYHdJuP/SRe2YgCn/xjsSw59Am1+qPL6N1BD8+j2yzh/aQSUxZg
         Z/Msi3inWQpRorUoKx+oJN8CJ1RNwpOZ98yR4ho41xLXwxSzuuuyr/WkHs0zHN8raiSx
         2rx5fHdGP0dsNXqFpxGd0VjodkANK9VBUf4nQEpqgUVfFgus5JKmgj5ZUhJEZb8nKMr2
         eyhw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771517785; x=1772122585; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3wg+vKqYtXz46jjz22+jIAy3md1p+mu/01FpEpqGKtQ=;
        b=a8QPnvWQVXiQ3vCrw57hF6k3Ua6BccPZWSlIZNgxvf3P2ZzxgMHbBFK6iEe7z+bB+O
         PPWvIAYJ/zqsFYDrRBPM+qaDeGE4N8HFf+WIXirOfvjpMPj473duT32y9GPFjeUmNSqb
         Ai5CSGsXm/k2jn+nkBcBwkbRudMC9hvYS4stFOjE9RhVrcnhr+uBCvlGMtZjd8mG9lKZ
         r4mXX979/2blLWH2LM5vXuN1Tef/AG7kMOG9z+PAwCjlGs0KHi+KsY6cJNtXTvbSnbAx
         joctbWXIFD0759fXuezhNkZAs8mWJT3YBxv1KHDICzIhe2KSb1FGG+qVcalBYkfyDZy9
         RZfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771517785; x=1772122585;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3wg+vKqYtXz46jjz22+jIAy3md1p+mu/01FpEpqGKtQ=;
        b=hvaBqDjeAIuHKb2qGzzZddqHhJXpxqFXCm7VdtHQbPWzOMfNnOek4vJDdZ6D5+FDC3
         LwwgiIdbRK93T+7p8VVPBowNmcqQvw3SwAqLyzV8bsJhOf29P8SbeHtlWEaPyXCmYFFw
         NhkqeBhB6qFf+mwjP21hHGtLdBFFj3jSph2lXkSnAS3Z26nopLTJ6OsMx1bj+67DDLUe
         ni3gYn3X+rspBmpL5wylQqWmlTvcQirZvSC8x+nLBJbQfq9Lg5+Ijeu3+C4jn20gQP2A
         7okHjjtFxSo22sfgU6A/vQJhvqIyzfjJUS/zk6U3csVO6HoR+fyqlMR951zwjg7TTFwq
         KGug==
X-Forwarded-Encrypted: i=1; AJvYcCURnWqnfLpe5YUWp1tj6cK0CRCnj6t4SxUEC9ppCPypfLUbXB4tSxnjFWgVJWgXwKT10bbuQKw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq9hsYD//yy3bRUznHeWDp9QzTMZvm5retxoOvluH/wClS8d8/
	oYZDDxmiMULOEbCboneHKsVdbOU3W0cbzxT41rY4yjdkOwTAedlpf1gibxKIWBq9oVr3mFWriw5
	tLcSHgTc8Hgjx6Eoe61kJRE61pK4pbbM=
X-Gm-Gg: AZuq6aKBtuObRuybGeXAAmgF4cJKeWBLX2i0JYLW81IBJLv9WiX8XynEMc6vo9CTvHm
	FR/O1y8pR50YH7g2QmQVxzLHDnj3f2QkcuP0uLIrNGJfwYLKCpM28ymqkBgklsqDhVcWXAmM3Ju
	bZ7LGZjS1qg7cgmscJ3ha9F/JIbNjC/npfavoB/Aduss2TrVtQxFVyECLLo88aerj9qKI5fHY86
	JwRAIzOYkjJOGEOrsOgh0nGMZiwSX42fH5ahnqHnr0anIX66zq226XuVJroCQoGuI3lCyMHGh26
	J/qgyOG1SSMrDgb1VlIweMTHxuNKopgg0cUDMDhJ7dS1YWNbnz5aXmaq6zv0EXNjKZLQNQ==
X-Received: by 2002:a05:690e:400c:b0:64a:dbe0:897c with SMTP id
 956f58d0204a3-64c21b7660amr13040987d50.79.1771517785449; Thu, 19 Feb 2026
 08:16:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADbaWgHykWB_EBiqp15W1C+v0OUMG2RXWv7zG_gocp2kgmkcew@mail.gmail.com>
In-Reply-To: <CADbaWgHykWB_EBiqp15W1C+v0OUMG2RXWv7zG_gocp2kgmkcew@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 19 Feb 2026 11:16:14 -0500
X-Gm-Features: AZwV_Qj7w7XpM4qKGYq59O1NQ2mRjhWHR2kGdv__vKpEOvmlN5Nbn82WRJoPHGg
Message-ID: <CABBYNZKPyi=qz-XfiNex2oS3DaJUQq-JN7uOxip90jaaHC2cHg@mail.gmail.com>
Subject: Re: Bluetooth: mgmt: Fix heap overflow in mgmt_mesh_add
To: Daniel Matsumoto <me@celes.in>
Cc: luiz.von.dentz@intel.com, maiquelpaiva@gmail.com, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-217461-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,gmail.com,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizdentz@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,celes.in:email]
X-Rspamd-Queue-Id: 54BDD16090C
X-Rspamd-Action: no action

Hi Daniel,

On Tue, Feb 17, 2026 at 1:09=E2=80=AFPM Daniel Matsumoto <me@celes.in> wrot=
e:
>
> Regarding commit ac0c6f1b6a58 ("Bluetooth: mgmt: Fix heap overflow in
> mgmt_mesh_add"):
>
> I reviewed the call path for this patch and the overflow condition
> appears to be unreachable in the current tree.
> The only caller of mgmt_mesh_add() is mesh_send() in
> net/bluetooth/mgmt_util.c. The length parameter is explicitly
> sanitized before the call:
>
> if (!hci_dev_test_flag(hdev, HCI_LE_ENABLED) ||
>    len <=3D MGMT_MESH_SEND_SIZE ||
>    len > (MGMT_MESH_SEND_SIZE + 31))
> return mgmt_cmd_status(sk, hdev->id, MGMT_OP_MESH_SEND,
>       MGMT_STATUS_REJECTED);
>
> Given that mgmt_mesh_add() allocates sizeof(*mesh_tx), which includes
> the param buffer sized for this maximum length, the bounds check
> introduced in the commit is redundant.
> While defensive programming is valid, tagging this as a fix for a heap
> overflow is misleading for backporters and security scanners, as the
> overflow cannot be triggered.

Yeah, well I would say it would only be valid to apply defensive
programming if that function would be marked with EXPORT_SYMBOL so it
could be used outside of net/bluetooth context.

> Please consider dropping this from the stable queue to avoid
> unnecessary code churn.

+1, will drop it entirely, it seems I will need to ask for more
evidence as apparently people are relying too much on LLVM nowadays.

--=20
Luiz Augusto von Dentz

