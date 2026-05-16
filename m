Return-Path: <stable+bounces-249033-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UNEHNnDCCGph4AMAu9opvQ
	(envelope-from <stable+bounces-249033-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 21:16:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C7EA255D800
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 21:16:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CE21D3006B4C
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 19:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 409B4363C46;
	Sat, 16 May 2026 19:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UQfe2kkI"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A7C364EB6
	for <stable@vger.kernel.org>; Sat, 16 May 2026 19:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778958948; cv=none; b=HonZuNPDH+Jq42dPPESQJy+NnfhqxJ0ZcB42p2tHfwrbH17Rldha7+gPJixdoDw97Y97XHTCzRgQRHx7K/hIpihdWCH8d9LsdVvZ5FGFa28wXbZa9GmfACI5Yf+Cig5Ke1MiMRF8bE8aBw7U0KU+moK3fzrWcG7mR4R5YJB9IPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778958948; c=relaxed/simple;
	bh=s/Ooxzr6FEZjkJX+l+du1+RJ2WQpB3zFWntZewkgHGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=llghQ6grYjEZrhf0t0VjYjdjZEYhDPRB6zEo61UjOix2CX7/Dt1CWSNv3m5FkUKb84f2WO2+vQW/EHo8WYtsDjfHzOeTN8A5/WHl1FaG6i7JfUp97JEabEZDU3rlZac7s1GB0qYWUPpYtFZNGQB0H8LfGyYXKVhkasov4dIHez8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UQfe2kkI; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-45d96d21e82so426651f8f.0
        for <stable@vger.kernel.org>; Sat, 16 May 2026 12:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778958944; x=1779563744; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s/Ooxzr6FEZjkJX+l+du1+RJ2WQpB3zFWntZewkgHGM=;
        b=UQfe2kkIXonQiMeAIwR+RaRaiSLUdOENX0iC8E++wD63I7zNGzyrJHcTrKXfWoLqBK
         8kmYgUXXNBNSkZoDlCKe9RKvMbolPVqGYSGJFyQU9Siq2d2maQZ3wcJFArHqYLcwLbJT
         9ZZsv5qnfNL6ggjJNLjM0kBNhpLKnm+lcVghvgMeMxPlWLMSzZKlDA3jygEK+VKyU+mT
         PWXQRkQXa38cFEs6ArR9mGvEoebwqZG0rh0gaLsDUy6djjakgA/0yECAhBCASHMt0yi9
         oEGVEibgoVZeAJZMOE/o6IXLdQCjoxaIydZPtMfS9IpEByIcqwn6E8TUklVeaORrhBrK
         U/9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778958944; x=1779563744;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s/Ooxzr6FEZjkJX+l+du1+RJ2WQpB3zFWntZewkgHGM=;
        b=sL54u5jyb0s/7uRtxmMhK5Vry5aHOxqmVnlt1WT0AsK7fPzCfbRbZnIbEUfXxr5gvo
         ifImY9/8nq0u3kJJVeLoBRbX8oeyge22x8ZX25IiKLm5CPCM1bRZMgooYbJ1ju1nwKFh
         gDMaCAtdY+HX4AS+qTl1Ee5xsISLqYgQEfgkCuTWAIeq7qO2vDJ3rX5XKLyj3gHiFEkY
         bxhTGAoZPC3Gi1glOhaPhg3hiNZm9En5+MveWph7JpjzXEIcDaxPrvh/gn+fGMIuAYAp
         ZZ//7Tvp2/Yel2wrE6bhDsdnclH0H/rVfqadQWWpuoTjG0JJf4gE1mrc6rlcmLmflw+p
         DfFg==
X-Forwarded-Encrypted: i=1; AFNElJ+BhMA0yb+aHL8eJes6x8tcgAr5k8SlUMwwMS5blG2zP9XcwtM4HEUBge2ebYTyJjhISOtOwLI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc2w6Y3pj7CxVN3pKFRk1dSY9OCGjLX+YIjmZ/o0yKMZlZRXWq
	Jc/8AIwcKW0w/9ul77A0D+Hou25wStcSX5RjeKi+1P9rAM/vvYJwP28=
X-Gm-Gg: Acq92OFnuVuwJQt66BMrD7rLAFPkSB7Gz7HhxqkN6+yUPtRXXx6VcG0xpSnXdZcisqk
	/v46l/k+2uxoY8j+qFuFET5hJxg1knRZ3Z82+lpbRN9hIBDZBpy6Shf4hD9ARoMBKAOyt2Hw6jP
	gNg5KkNuxuzM/Hj5wk0l9uLAetbIRjoWuv3bn1CVk0HFiDd8HhG7SlDaSViQHYXfaPlTp160InX
	r5uE13Z9JQDAiD9lc+Mw+T++za8AcbHd+29eIuXQZod8e4dQNuzzBGQojAjcQGAIlu3+uHWbZYu
	RIc3wxoKtF8+EfFBTywODHYP8vWAFv/XxOKik3WHj7zvOgxCKw+QalxwpqSylJeOdPsZY5dPr7p
	VQ2uioD/LCSpML+03EYPwfCjDAOH141TN2Q6tSxzni4Ce6htz+demv2tOFFteyNig9A==
X-Received: by 2002:a05:600c:a4f:b0:48f:e230:c3f9 with SMTP id 5b1f17b1804b1-48fe661df4dmr117083015e9.31.1778958943323;
        Sat, 16 May 2026 12:15:43 -0700 (PDT)
Received: from debian ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0a19a0csm23663118f8f.20.2026.05.16.12.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 12:15:42 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: shivamkalra98@zohomail.in
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, luiz.von.dentz@intel.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: btmtk: Fix FUNC_CTRL parsing for devices with
 zero-length payloads
Date: Sat, 16 May 2026 19:15:42 -0000
Message-ID: <177895894204.2999813.16690091301048694150@gmail.com>
In-Reply-To: <20260514-bluetooh-fix-mt7922-v1-1-499c878af1e5@zohomail.in>
References: <20260514-bluetooh-fix-mt7922-v1-1-499c878af1e5@zohomail.in>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: C7EA255D800
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-249033-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[holtmann.org,gmail.com,collabora.com,intel.com,vger.kernel.org,lists.infradead.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Action: no action

On Thu, 14 May 2026 23:18:13 +0530, Shivam Kalra wrote:
> Fix this by making skb_pull_data() conditional: if the status payload is
> present, parse it as before; if omitted, default to BTMTK_WMT_ON_UNDONE.

Makes sense. The original check was too strict for devices that
legitimately omit the status field on FUNC_CTRL responses.

Reviewed-by: Tristan Madani <tristan@talencesecurity.com>

