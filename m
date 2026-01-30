Return-Path: <stable+bounces-212902-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CAFdEjX/fGnLPgIAu9opvQ
	(envelope-from <stable+bounces-212902-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 19:57:57 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2612BE065
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 19:57:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F16E630160E5
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 18:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29333385EFA;
	Fri, 30 Jan 2026 18:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EGg129+g"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CE234B19A
	for <stable@vger.kernel.org>; Fri, 30 Jan 2026 18:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769799456; cv=none; b=khse1Q+Nunnw6svewHQx5/9cZf8ODrZUyQwgmvmuyMaMjT7OTIaUoAL6MSXAV4eEjhwRN7BgqhM3O6LKQymwrF8nG6K7PSc06c+ulFdXzxwQHbaW6MEduWorxJkJiuahtVkxTPqySDAEElts6OS7NAqdb4Ctp3D6Ksu03HZTL6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769799456; c=relaxed/simple;
	bh=54jF80axLN2UJAh0SY0zu8J2BqHK+0mKcS7a+qODr54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tkp3NgcloW8Bbt19dwBdRzC7GYX9CGZx6pQBjA02/xYj6GS3bIj/IvbL7MopKIFgvJmDg22+ivIlfbKzYMoN/Az1aYBQ7HLwXrCWb9nX9aFh6CcRk8Xhl25Lt8Qgd22ckqOO2xviAN1T+pbP2yv8l+RdYAvTQ1ebAUCpxjvZ8GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EGg129+g; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-432755545fcso1657109f8f.1
        for <stable@vger.kernel.org>; Fri, 30 Jan 2026 10:57:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769799453; x=1770404253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z2f4MfuhNu/cLjFrGUoAiSMm/1GSuujiaDwedPKXZAI=;
        b=EGg129+gaCIw5YZ2hFewK7PC5nvYslLDZjLVDYQfJJpfSjne+MATYsP6l4twJZA7xx
         W54CTZumHyp/dgu9PdJ6x4P5GwbJpAivcFv2/ajfuM3Ogf4AKulu9i9IC4CnPz0tP7ar
         ZRseyYd6t4kALb/7fJBULtXLxVexpHtWZJ+dX9jwe0ki4/9XdHTD1pn7V0mLB9o1wXyv
         0L7H/0sIi2uXNcDIQBqx+SUSp8hnlDfCmBKNzoha5gSgEh68SU+oTTKMl2pzBMO8du/4
         n0kxX+kO1AQldTVpRQem551wanPac+ao4EdjlEUWLKh78C9VJwHKr6luYsi7IFZjB7W5
         +lHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769799453; x=1770404253;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z2f4MfuhNu/cLjFrGUoAiSMm/1GSuujiaDwedPKXZAI=;
        b=r675n2qb2biVxGDZmz9LSBKzxleJ7rz9yuYXdSe+ZK9T3ichO4v0ufKkL2asFbPehc
         9xAdsY0u8uQSIggn53Hm1H5Y2p33MJul5n0wpG2WbObaGRpYoiPEx1jj0uUehywweSeM
         gbc5v6IVbRMDTnez132urOw4PJLuLMLAfR5NnPgzp//tZAM+y2egMJuoPTufoW88EETE
         dQh/GqFXBMtBYTt3N4M8FBsHTVRcwtcnDdcll9NLYBWAbVbsSo2zaJlxpLsw3kNq6lON
         b8BXGC2pG6gvuKY0GAGEIf1t2VezO77OpWVTQmKjjREWBoi5PVJOf4Ctz5RAVee/pO1a
         gsCg==
X-Forwarded-Encrypted: i=1; AJvYcCVzZD8Wu38mZfHh8KfbbQaEQ+GZyTdK+tMn+UD/x/rsUez4B+zDFSEdKXVqdvWYaJuyPG3vnVM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1BIUBNDCQDWEH0nVX9iBL8hNtp5HEpayVX8xxSl718AMepXPj
	ugTpNc646Ws7kSNMn3iUXX7jAs6/koTp80rFVpTvklMh6vC6xO1XrPk=
X-Gm-Gg: AZuq6aKyLsPTvWFdLRbp0xUQLCy6S4vk3j1uv6umgOuUFjFE90VW+PyjKAvedjotESo
	em5bHHXjvr1vokIOcY9TnTTYh8i3ZW0j0xtu902T20odqwmu0HqlQwcc0yWTP2ec3nno5vK+F7i
	O+eyCAEaZ3w841+TALBoyq0M5TgcKpVbNDNOeWuRQ0iqXg2KrKOrY7b3dMM5BqsAqETJJhzCmZX
	VxgsaTX7MegpNhd+42ghymlDtLvl+qBZGaaCA+19Bj5RL1h7WHKVv/gXk6DdL9dVx1qUPSTXAel
	F8VRa4YKzjadzjEa/XhWSmkdVXVGDEPR77bJK6iYeELmqIOHRm6WbdM9W3DOb2xFaXmTDAaKgiE
	UP434k7oPGxIye0aZC7Z/aBqWwBEhnWmcsvj1lv3+Ykb39/fygsjBzuBNyIs/z2wQD4YHN6R/D7
	wefM7E+GZVlJ6nSwfBh/aGzcXhWQV5msIAXCut+veLnr+TpYVcCtX6kZjCSgpqdw==
X-Received: by 2002:a05:6000:420d:b0:435:960c:5286 with SMTP id ffacd0b85a97d-435f3aba816mr6032365f8f.58.1769799452718;
        Fri, 30 Jan 2026 10:57:32 -0800 (PST)
Received: from LGPC ([31.223.131.55])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e10edf62sm26474164f8f.13.2026.01.30.10.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 10:57:32 -0800 (PST)
From: Luka Gejak <lukagejak5@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Luka Gejak <lukagejak5@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v6 1/5] staging: rtl8723bs: fix potential out-of-bounds read in  rtw_restruct_wmm_ie
Date: Fri, 30 Jan 2026 19:56:54 +0100
Message-ID: <20260130185658.207785-2-lukagejak5@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260130185658.207785-1-lukagejak5@gmail.com>
References: <20260130185658.207785-1-lukagejak5@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linaro.org,lists.linux.dev,vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-212902-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukagejak5@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: C2612BE065
X-Rspamd-Action: no action

The current code checks 'i + 5 < in_len' at the end of the if statement.
However, it accesses 'in_ie[i + 5]' before that check, which can lead
to an out-of-bounds read. Move the length check to the beginning of the
conditional to ensure the index is within bounds before accessing the
array.

Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
Cc: stable@vger.kernel.org
Signed-off-by: Luka Gejak <lukagejak5@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index 98704179ad35..7dfc2678924e 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -2000,7 +2000,10 @@ int rtw_restruct_wmm_ie(struct adapter *adapter, u8 *in_ie, u8 *out_ie, uint in_
 	while (i < in_len) {
 		ielength = initial_out_len;
 
-		if (in_ie[i] == 0xDD && in_ie[i+2] == 0x00 && in_ie[i+3] == 0x50  && in_ie[i+4] == 0xF2 && in_ie[i+5] == 0x02 && i+5 < in_len) { /* WMM element ID and OUI */
+		if (i + 5 < in_len &&
+		    in_ie[i] == 0xDD && in_ie[i + 2] == 0x00 &&
+		    in_ie[i + 3] == 0x50 && in_ie[i + 4] == 0xF2 &&
+		    in_ie[i + 5] == 0x02) {
 			for (j = i; j < i + 9; j++) {
 				out_ie[ielength] = in_ie[j];
 				ielength++;
-- 
2.52.0


