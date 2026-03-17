Return-Path: <stable+bounces-226912-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +CqHKGLIuWl/NgIAu9opvQ
	(envelope-from <stable+bounces-226912-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 22:32:18 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AF332B2B9B
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 22:32:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A703C30A2FF6
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 21:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE37639280E;
	Tue, 17 Mar 2026 21:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="JlNrQo8U"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0482DECDF
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 21:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773783131; cv=none; b=seBvLatRKT6gx1KFs0o2U2m1oH/2qeT0OyIq7q/tw9syFA2T4jZVn0vSEqgSCO011wXYfbr8YhJ3sxAS/tCJLTDdw2wMzROBaf7wLcmRp3lJlRRM8ih7OL8oZDqxFqUbZTX73XNZLyo+UneUWgt8WyyGisS97OW9xbaApi9Uygo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773783131; c=relaxed/simple;
	bh=5hJfdIl1jSXBfJzoHn+vgpDYPdEAfAw3oD1/jC5U+aY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YXFcGK42QYIWp/G8Bh6W/+gJ5DeCUZZ0C3mcSG3U2GZmgRudfUc6xrWuFqbWFl2QnVbEhXp/uCqBdRf1BrCdlen3hs7KLTUF91grFWP2Eq4aA8dFa2t+1Vehu9yvglEiCSzznEwqarUcZSKEfQRMsWAWN0KDXa5DqcyfUpu+Gj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=JlNrQo8U; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-485445e80bdso54048405e9.0
        for <stable@vger.kernel.org>; Tue, 17 Mar 2026 14:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1773783129; x=1774387929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5hJfdIl1jSXBfJzoHn+vgpDYPdEAfAw3oD1/jC5U+aY=;
        b=JlNrQo8UWDd6M628v1ESxEAt+3BhFZ3EZAmZk1Li/tQyTsAKIayrOoYnC6ZtyD/Ygq
         B5HgGTFEvRSdRb3PCzRfe9nlHVcejMeehQPTBhuFdFCxnPmwN++I8lhEugsM+x822qLp
         kxQ0pkA2Z7q9YMrnBRmymMsEfeF+zyVKB/WZIrxmhQakmHmMWtgxTvzvVVms9MWauiA+
         okZKMCj6sLKZXd50+FWO9T7lqvXExzVbbY8GcUAB6L9d2h23m9XMot61wTUzBTM2TTuF
         Phz/jM8nao/Y1gGWSgkD+5Zd6jIEJpVxk2j1pYU+lzdE2fyB6jDq+7r6DvPhBNc0vOO5
         jGvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773783129; x=1774387929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5hJfdIl1jSXBfJzoHn+vgpDYPdEAfAw3oD1/jC5U+aY=;
        b=bwamE7A0NPSNf97gWK6Zpe9rhH2m1cGJpwtAhL6pEyqsVOBQZ/gFDE7wzzbr7DvEK1
         1OJMVbUnwciVWRsfxQC2cDnWLEZmZlqEe5F3CttMlfu/+MrEPLjsUGF0VAFoHCrGyc0h
         oiGB3GaR6FkWqrN6tXY+Egd5Bt1kTIcrBedM/cQo/TZa9+w0bdXJmHAdF614O9fDot9D
         MkmraABsnPlV2y5pCNlq7cfiDilbw+9IrbbOhJTTc7DAATzkVc9e1WrlYrvBL9DmYsfF
         F/m+U/fUb0SpUEzaIsjucGj1/QgrqgcIf0ZAmpAUwg9UXJZEz8HObL/1D4J5XeD1v/2f
         33Xw==
X-Forwarded-Encrypted: i=1; AJvYcCXDzk9su7+WG8vR8dCImKzJ5wHf1Fy+bMT80GPC9Dtj70ynCRHQuv8ikvXGQSxVxpwVcXrJ6WE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuTYSMb44tv8D2mnRG3Lfi4KESPAHcQRHKlx2Zjf0cyLzxxSil
	14HheaNxHBk6I8PmRtlORxJjXSHv3peRFzap7jHDM8Gef0d7e9OVvYZt
X-Gm-Gg: ATEYQzzhv8CDlYPFifCEwRBPrkuePca6w/QXk5qr54xIuiPVYl8o4MYkCIj3cBdRMkA
	yYwYxEMcrqx3wsDw9Dq5LYSqzT0I382m0V68SJh0q5yyQdYCFlQnAiD5imPIyaGl2e8aHaOZ83/
	AwSCmxjfAxT5oC781Lu0HQzUmNKjCipHh36i6omhXFlGVmaU47L+r3f+l0Ur46Rmsy3msMCKZe9
	JI47U//rvWGwzvYi3YBibcgS2167GO4/dlvwlnoDxQWhB7Z3EdsLbB+G5IIKoIcntlf9lZlkvT8
	Z0Es14Y+S4ELfyFM66gTa07cqYFlXx+iUJwrn3qeKLZb8TeAm2jm5sY3qbZ5H+t359LunWe3ROG
	ywpYWwSBJfBQTzKcYREHGHqGdjcoyNriWOYhjvxsTVzlqiXxhMtDFO+LHBbuhwdg1M4C8nFJPUk
	5wGTjxRYorJpQu7kb2sNw=
X-Received: by 2002:a7b:cb8a:0:b0:485:35d3:ce59 with SMTP id 5b1f17b1804b1-486f4451174mr11909435e9.10.1773783128440;
        Tue, 17 Mar 2026 14:32:08 -0700 (PDT)
Received: from DESKTOP-I0B9J3E ([2a02:8071:5392:3220::bcad])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486f4434750sm16736535e9.12.2026.03.17.14.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 14:32:07 -0700 (PDT)
From: buermarc <buermarc@googlemail.com>
To: ps.report@gmx.net
Cc: buermarc@googlemail.com,
	elias.rw2@gmail.com,
	joel.granados@kernel.org,
	kees@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH ] sysctl: fix uninitialized variable in proc_do_large_bitmap
Date: Tue, 17 Mar 2026 22:32:05 +0100
Message-ID: <20260317213205.13681-1-buermarc@googlemail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260315152635.4c20c6f0@pc-1>
References: <20260315152635.4c20c6f0@pc-1>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[googlemail.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[googlemail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226912-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[googlemail.com,gmail.com,kernel.org,vger.kernel.org];
	RCVD_COUNT_FIVE(0.00)[5];
	FREEMAIL_TO(0.00)[gmx.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[buermarc@googlemail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[googlemail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[googlemail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,googlemail.com:dkim,googlemail.com:mid]
X-Rspamd-Queue-Id: 2AF332B2B9B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Marc Buerg <buermarc@googlemail.com>

Hello Peter,

c will be overwritten by the previous proc_get_long() calls but that
will not be a problem. We only check c again if we had another trailing
char in either tr_a or tr_b[] = { ',', '\n', 0 }, minus '-'. If we find
a first '-' we will only reach the check again after hitting a trailing
char in tr_b. This ensures c must not be '-' before we might encounter a
new '-'. Meaning c should not contain a problematic value in future
iterations, but only in the first.

I agree: checking for left, as you proposed, should be done. I'll drop
setting c to zero and create a new patch which checks left.

Kind Regards,
Marc

