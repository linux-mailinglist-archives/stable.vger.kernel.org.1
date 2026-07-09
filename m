Return-Path: <stable+bounces-273032-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id m9QNBUz5T2p2rQIAu9opvQ
	(envelope-from <stable+bounces-273032-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 21:41:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 935B6735197
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 21:40:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=M2NjRLW1;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273032-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-273032-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EDB4530065D1
	for <lists+stable@lfdr.de>; Thu,  9 Jul 2026 19:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 938693C1095;
	Thu,  9 Jul 2026 19:40:57 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24703B9D99
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 19:40:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783626057; cv=none; b=LYcpCaLnI8YwLy7nDhvTQ41O05RdYStB6ls9QM+5O/7SZzsWSWsb3PRuMVlhhePYZHRCkmMqAldgmXws7UiAPeSSMEh5TO/lgqPOrUfvq8XVn6kb+YZS3O1xqZDGXLkOBFXIlI6ipkeNx4U7O4INl4H6Nk5XNRHcl6UB9Af6J78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783626057; c=relaxed/simple;
	bh=sjHPNudmGjASxiXnhJxMGLO0lZ1OTxOJvgPfI5PJdRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MF4IHwcj5XPgx6DWSA1KhhkOGtLjaxJ+RvKSn/CzId/XlTlLD/L4RAexaVJOizcTk7GilHQq+M/QGUJAB1x4njYgt8Zb2k8f9qVueGIoSVAgHAqUKfyh8flSCcOjKATosnFbRWdlqqfLFGxZ3wcwXB9prmxE62mp1QsOdahHJZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M2NjRLW1; arc=none smtp.client-ip=209.85.221.51
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-47ddf7b09aaso156982f8f.3
        for <stable@vger.kernel.org>; Thu, 09 Jul 2026 12:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783626054; x=1784230854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dAikG/7yEzn2lu5SwT7tE+7mn1kX8UbVHrrg9LrEUCE=;
        b=M2NjRLW1tM5q/NKxW/02B9Rv8uuGnauSDSF3yhACVnQXTakBQQAhzTg5/39tx1Ij/O
         Sw4k/dHVnuPtSNsiXO8v9+SilnehyrzNhmyfHeS0LSGWquWnwKlIlxDlk2/gaZz09TEf
         QtGX7X1SDdnXXozGLeOOkF1AFzRet1yv+o/X0JS6H05ZXXZRN7yF7z130SoTgD5WDdac
         XolrpOz/TpIZArrOdKo23gUSR84ABkBFCoTW0sarzTGEC1Lj5xdDZnylkHGjqboFXFs1
         0zn1vR+i/r9mKvNO4V/qqVB/jRVtXYBh77w6VCRgoIQPrFQecwyCfLMlQhXo4Sz48lx7
         GWMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783626054; x=1784230854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dAikG/7yEzn2lu5SwT7tE+7mn1kX8UbVHrrg9LrEUCE=;
        b=psMNVdZkmAvoh3D3nka3fIeVjJnnrQV4MCDHCZfAm0gx4/kp/actvY1p4fPDkFzU53
         y3teTuqbMEvBbg+B/j5SXUPxmonl9J8Bmg5Ln045ak+2rb3buTlzGU+AxgljbG9Q4dMr
         p781xLbIVATmLn3ECFTyXLSZ4lpdSScd1MPvhkKAwd7hHEP80sTr4ZGhQXrLBD9QjBk1
         W1s/cI8AnE+CVhlqdKoGe6C/jDp5xtMGuag5qESaJnzFl57PV6OFLGEat4Cc7Fbv6rJv
         kaIk0DSUfowhluRsne04iogrGx7Wx3EENvOofjnoZwjUkqkgRHu9ccP0VwKpiIEIhFB6
         5uTA==
X-Forwarded-Encrypted: i=1; AHgh+RpsKsmKpcszfGtu8EZhY8TWQydniNlWgtI05U5eh5xrY27uLbtQGPV6DniO1ADPaFQKjJ96eK0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHC81qQLtxXKvOOy5ykZvjWpQqvreEVeyXmQCj4CEBDk754W8g
	QtWvjikGxMOH1hUOwOXKLH33YwxMrzTIX01b3LetDyNxeG8+dzS7LZMl
X-Gm-Gg: AfdE7clMXwT+/sl/oTAUT6m9oIwyZ65YNZMnVMbvYaETcn7euRX9dk2hFSsIRdfeJwb
	DUcn4v+VLLqJ/zvn/QDE03caRNjPL8WfaKfPUajbpjIq1k+Ky8gqIfQqJ2ucuNN6eSl06XwoT0n
	2m7gYbsiCqubZSqNiZFtk7P0ryePuxCLujatxbU4Qm0xxkzX7nHj1yRAc5WUYGWsaEAWUWMSKoe
	UxNoS3dBq99CNP7p4fUJ06QaJAEtm24V6IQNiSDew2bIpTpEF2VEuLQWpyB3mS4P5WEsLg18BUX
	qYvuGiCLOktBxvvdurewT+PaKr0L0gtvZNFb9yixX4C5ud0HYoawOxS384/QKQCMCXhy49b7D1A
	mYvbIQ4kHfI1zWtw5wjs97PJbTnT/8Y1rOHl3z1SHiB3D8ZAIrHvQFkUb9S89oDXDsiTAdTjkVg
	Dl0t5gq05A6+ecXGUYhqkXVrwV
X-Received: by 2002:a05:6000:4010:b0:475:e015:c2f with SMTP id ffacd0b85a97d-47df071e23bmr9168721f8f.1.1783626054110;
        Thu, 09 Jul 2026 12:40:54 -0700 (PDT)
Received: from mini.main.internal ([2a02:908:c211:cd18:d9f3:ab2b:ac6e:fc84])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0a558easm53986441f8f.27.2026.07.09.12.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 12:40:53 -0700 (PDT)
From: Goetz Goerisch <ggoerisch@gmail.com>
To: gregkh@linuxfoundation.org
Cc: ggoerisch@gmail.com,
	herbert@gondor.apana.org.au,
	herve.codina@bootlin.com,
	linux-crypto@vger.kernel.org,
	miquel.raynal@bootlin.com,
	paul.louvel@bootlin.com,
	sashal@kernel.org,
	stable@vger.kernel.org,
	thomas.petazzoni@bootlin.com
Subject: [PATCH 6.6.y v3 0/5] crypto: talitos - fix rename first/last to first_desc/last_desc
Date: Thu,  9 Jul 2026 21:39:51 +0200
Message-ID: <20260709193956.15619-1-ggoerisch@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2026070912-pluck-bagful-2a71@gregkh>
References: <2026070912-pluck-bagful-2a71@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273032-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,gondor.apana.org.au,bootlin.com,vger.kernel.org,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_SENDER(0.00)[ggoerisch@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:ggoerisch@gmail.com,m:herbert@gondor.apana.org.au,m:herve.codina@bootlin.com,m:linux-crypto@vger.kernel.org,m:miquel.raynal@bootlin.com,m:paul.louvel@bootlin.com,m:sashal@kernel.org,m:stable@vger.kernel.org,m:thomas.petazzoni@bootlin.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ggoerisch@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 935B6735197

Commit a1b80018b8cec27fc06a8b04a7f8b5f6cfe86eae
was backported to 6.6.y with a866e2b1c65edaee2e1bb1024ee2c761ced335f8
It renames last to last_desc but misses one occurrence which leads to compile errors on mpc85xx

drivers/crypto/talitos.c: In function 'ahash_digest':
drivers/crypto/talitos.c:2204:16: error: 'struct talitos_ahash_req_ctx' has no member named 'last'
 2204 | req_ctx->last = 1;
      |        ^~~~

Instead of renaming req_ctx->last, commit 9826d1d6ed5f8 ("crypto: talitos - stop
using crypto_ahash::init") should be applied.
Ideally before commit 00463d5f864a ("crypto: talitos - fix SEC1 32k ahash
request limitation") to avoid any compilation breakage and ensure correctness of
the code.
 
> > Greg could you please backport the mentioned commit to 6.6.y in the correct order for the next update?

> Can you send a series of backported patches in the correct order for us
> to apply, so we know to get them correct?  Trying to dig out from an
> email like this is usually quite easy to get wrong :)

> > We need a reason for a revert, AND a signed off-by line :(
> > Please fix that up for the other revert in this series and resend.

Thank you Greg for this feedback.

v2: add reason and SoB to revert commit which was missing.
v3: send correct patch set

Hope this is correct.
Goetz

Eric Biggers (1):
  crypto: talitos - stop using crypto_ahash::init

Goetz Goerisch (2):
  Revert "crypto: talitos - rename first/last to first_desc/last_desc"
  Revert "crypto: talitos - fix SEC1 32k ahash request limitation"

Paul Louvel (2):
  crypto: talitos - fix SEC1 32k ahash request limitation
  crypto: talitos - rename first/last to first_desc/last_desc

 drivers/crypto/talitos.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)


base-commit: da47cbc254661aa66d61ef061485a7080305c4be
-- 
2.55.0


