Return-Path: <stable+bounces-241821-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GPswJRCc8WlfiwEAu9opvQ
	(envelope-from <stable+bounces-241821-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 07:50:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 47BE048F8BB
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 07:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D6CBE3019CA7
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 05:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41AF43750AC;
	Wed, 29 Apr 2026 05:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cpNN5BCU"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A222D876A
	for <stable@vger.kernel.org>; Wed, 29 Apr 2026 05:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777441794; cv=none; b=HIoU8vHUkL0k5D2YJ+eCCNjqj636oYy19tV0nF6TCRH8evkpXL2UKb2kW3dq3jli5EG9DIF1qmrySKpU8QnZfGgi49d0Udyoa4ab+IH2r4rjlhcZVj5ajua/KXPDUcgHy2KiLcPCuInsRe1rsq89PSCaAhtI4vc+ZsFrjJ8jKJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777441794; c=relaxed/simple;
	bh=6PwYOWPOOYvG2DrrZTt6asbW3Y5Zvj9XwiRvbY3CzYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q0vDWMkR9utYbqW0vNLqCD8swqm+W96kG5oS4v93H8ejUwntMhmGr+R18XjrQ8R81SoRodep75av55AzsISmPWBngBEvuPJouSEhUvXzHutP6BdjFkw1lSRQa9hMQPE3y+HRP88QUNmVUdl8N+MC9y3B5oR35e+Qg/5Bl/qfSFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cpNN5BCU; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-82f8b60e485so5070723b3a.0
        for <stable@vger.kernel.org>; Tue, 28 Apr 2026 22:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777441791; x=1778046591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hK9jzP1pmenmFL+uCGEOE0gremklqtqG7a2J0RuJ4fw=;
        b=cpNN5BCU6nyimoiKksmkJxD5v/6S5XhyPqXPZQKSmpaL10FcfPIzJ+gyBlodXbV865
         DmaAiAX8852UZUHDxFKkPPyvqTmAOUWYnZ0I8OjqhivsQlHY3xPmrb97KupBlskz5rum
         iTELQhNc2YV45ogoA7PKwsjX4N0vDW68K+zYu7zQ9cJHG8IUdjW6N0N71z7mrOfRtfye
         NlJUUX/2SVZoCgr+ff+iIqjmbjRmmXYdbhamXQ776DoO9gWcr2SFgnCtFXt81opwLOz+
         fSwUUOD3DF7oniGs3/3lRSrFDTW2Uj7QwFdohP/lO15n5FhHXmaTEhFTBUI1g4f7vPZd
         MYBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777441791; x=1778046591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hK9jzP1pmenmFL+uCGEOE0gremklqtqG7a2J0RuJ4fw=;
        b=dhL58V15aMoIzqz6fz5Zun4fhlflDLtCoab0dDOkNgFWiyqWW0eO8ZGi2lUaeqU3y5
         pfXNQLGB4oeBivEtpW5dGk1EHfT2Ktmr0+JgdglcLo0EzcKhBqv5IFzI1iBHZDqNWWLf
         Rtzv78u9Q251IvN0ykDibRxTpkK6r7swM0pUTQaDSiMoneGZjE17DNTuHWYw+REpD4in
         44nNHYUZvW7pJ3LVwPQ1lV+k46Ocln2imLEHd+8STGhjVCTl9ZLtnFbMKfaTz2DrAR+G
         E0Ojv6Rnv0TTKLc0I8p91HxxeiTXVoZfiOzA1d3Rr2uCtTTNyCH4cqdI9ERpwzoTHJiM
         PaMA==
X-Forwarded-Encrypted: i=1; AFNElJ+OHs/qFi/LuMxzNMWbHO1PIXJcYcy1UWKnEVzErxbJ9SKEWR1PEvF4bbXNYsUAxClhq/6Ar7I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyP5W3KKfizxGqlXasZhuwGABW2rjpfylSPxsdH8DSK/q3zJGc
	JGn7JdeMnh/KabkcTft47pX0+qSP58AIBExRL+YURu03G2ShVzx3xkCs
X-Gm-Gg: AeBDievNkNDUKe7xQDXGW2SXCCQtuWwWsf5JgCRBr/FEqc87tNOzvKO0qebVk38i3Os
	AuGZZtvnqnn62Pef0R7LIkud7jMtZRyEqtzclN5l2ZshBp/qbIyMLyPhOYLwNAf1MG2M8DhOaac
	S+zOYAKQiXWf848AHzJS1VOmGwe3FQZy7ewUk5XnrMc385Ct91W20BUTin1q4E8UR+Em48B2SQ/
	gv2PQwW7jZOdhFn4Yiceje/697MTkZOpwsDm6HgLXvtnCzSmlN9T92gnarCQAjqFda3QOuKlUoI
	TCFzxrlZOewi91hsBy9FhGC+wcqWXhQIcgFcimZ0tIcXwScyEd1C6lxrTA7f3piqB7agtP0vGHH
	drNySu9sAkeDG5fYl5CKXEEKRttO6gDS4ezybQHeLIYVEEeT1B/+fMUIN9LhVOsHuppwnGgY4dC
	0+oeMB5ES4iQlOpcV/myUU3zAAaIRb5oQ07/eckQOKX80o4LbZGOexR2EdBAXZ5Fd22g==
X-Received: by 2002:a05:6a00:2195:b0:82f:8698:101 with SMTP id d2e1a72fcca58-834ddc8e799mr6066874b3a.44.1777441791302;
        Tue, 28 Apr 2026 22:49:51 -0700 (PDT)
Received: from KRHW1CJW23.bytedance.net ([203.208.189.6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-834ed5cd3b8sm917616b3a.16.2026.04.28.22.49.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 28 Apr 2026 22:49:50 -0700 (PDT)
From: Zhao Li <enderaoelyther@gmail.com>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org,
	Felix Fietkau <nbd@nbd.name>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] wifi: mac80211: drop stray 'static' from fast-RX rx_result
Date: Wed, 29 Apr 2026 13:49:44 +0800
Message-ID: <20260429054943.98326-2-enderaoelyther@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <17d5b91c-026f-4539-a39a-cfd976860273@oss.qualcomm.com>
References: <20260424131435.83212-2-enderaoelyther@gmail.com> <17d5b91c-026f-4539-a39a-cfd976860273@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 47BE048F8BB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-241821-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enderaoelyther@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Tue, Apr 28, 2026 at 07:23:30AM -0700, Jeff Johnson wrote:
> Is this an identity you commonly use? Note that anonymous
> contributions are not allowed:
>
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html#developer-s-certificate-of-origin-1-1

Apologies for the truncated From line.  My full name is Zhao Li; I
sign other kernel contributions the same way.  For DCO purposes,
please treat this patch as:

Signed-off-by: Zhao Li <enderaoelyther@gmail.com>

I will use the full name on resends and follow-up patches.  Thanks
for the review.

--
Zhao Li

