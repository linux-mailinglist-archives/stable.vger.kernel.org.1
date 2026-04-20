Return-Path: <stable+bounces-239230-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2OWOHOA95mlutgEAu9opvQ
	(envelope-from <stable+bounces-239230-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 16:53:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D5742D90A
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 16:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3B7003024172
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 14:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3F82E719C;
	Mon, 20 Apr 2026 13:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eX1CBI0I"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF2F2E11A6
	for <stable@vger.kernel.org>; Mon, 20 Apr 2026 13:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776693066; cv=none; b=RqRQ3+MyIBuSLZP3ljnUzJ+6sLCipD68QADsbyRoZS3ONaywdjiNxOVr6d8InoW0fp1du4Dr5jzSFOC83QZnQXRunC8/Bgsm8xGUmnnkht4lTb2P2V7ApTp52g1TvgwW7jGmpiVjYfg8MS1jrq/SYelUrPoGo52DcpswO7bJoj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776693066; c=relaxed/simple;
	bh=vmZvs6UHY7QD3B9MWYRhLwssp9+U49BA9oDYPNJlnbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X8j040IwbWQnir4G/Gz6GwOL/zxqOX8wT0+DaUk0aqODvK98Br+lcXt6KDNSXpffc1Der6vfXefdX+xITt1RrD0G7S6xupqXxSs6jHZG2/0Gg5/D9rPhDjNmlPOQdXDyjWq/i2V4By/8KheHDo6of4meDJ6zb8igF3P6z+o6PFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eX1CBI0I; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8d736211595so190401185a.0
        for <stable@vger.kernel.org>; Mon, 20 Apr 2026 06:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776693062; x=1777297862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2CQQpu+pTCuIRdY5y4O2DIzGNhbLx1QOGGuLTzhze6c=;
        b=eX1CBI0ISZbv2Dtqx9JEmkmhtO9WaeFmWzGJxfDY58gGclDPTjLddsg7dijrhcFXk3
         8tikwhZAkUd9yivwOGS4nIrbrPlVeeTGyt/QJ96yEgr2rNgWwVmR6Eg/svqHb0XY8eee
         j/erY13lySWTYWbaCnMMrA/QnmOV9zEkqEYFVXgvl/uXL3B05RgaFYiKDv0MCuenp0ZR
         ig5Dr2pmSIRFGnff1TeBnfbk28J5SdUTENMRYPW3kQY+UlPA98EdVDdf4FauSpOxG2o6
         yy5ycx8LcPKoGDCGjfqCR1naZ9Iew6mwU7H9zVCG7VyQiOcXlo9D55lcHE73dtJQnGbZ
         LEbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776693062; x=1777297862;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2CQQpu+pTCuIRdY5y4O2DIzGNhbLx1QOGGuLTzhze6c=;
        b=nHdZ1jp1vqi2lL3iGqjnYLdjkD93bsu84UruAZLJem8y5nvH6LIm9wczX3uNwOqUHp
         JIe6OfexeYRE/T+j80rzTJilIiYHWILV9PoPKfcUNKsl+/9HwLda1UTSAdTFUTzdiK3J
         KvLyDPaThHo+u+s2FzzN21bK4SB/emcmbotrQvbHElc083bDeWGjXLyMEyOsVufI3Lqx
         tSlQKI7IudWMMl/Eb1YTXbV2pbIRL5PPkNj8pPDs+ijGABQKBU+wfmcjAcAh1i+Yjc/w
         dN177wAR2K2edS7a9KdSjtmiORlfJV8d/pyxEjAlKQHv4Yt853LBpAxtGjDtVAmHtapq
         3qPQ==
X-Forwarded-Encrypted: i=1; AFNElJ9dXrObp6asizRJEWA/YR1crhB5RUUJM/WFFhk23WYfDUihTco0FiJgwh9PhhwIQdijWNf7Qfg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU1GDJnfs1u861JpgFgMZskuwUSD8HVVD4EiDyOPHT9Da/hrTY
	9f0Dzy5Xy/9NtLvxtZzO9GcdpQWtRX7lZtKWN8BGOoWb/TsT+ot3rYiu
X-Gm-Gg: AeBDietgTGvoiCuLos1B/mBlHgZK/sfZkK+JewOp3u7BeaMYEwB9iNdHYUV44teRHFJ
	VYJbrSZ/dBist2BofDISQ6T1oInQDggVEqQV85XSRAzaOVQu0oMJXDzc+FXxnj5WxM+iQQpClWb
	eEAqy/uQlWFXobdjI2UhbXdrCflO8HYCc5JLhjiTaicHV3ILvmr8DGjJ13ppI+ZiwqRgOJGJ3QZ
	r8/uxLMNtxolbS2gNcbkKGyQ1dHm0aQzsO7ZYxrnIIsA2K5y7TtA9+YstEr27eb9pZyZn+yOGIT
	x6RbQDoluCOwPuMoJpZE0afYbFV74ehKmUgOKzIa1qdCzpaynKB70a03TJXNUqusuSwMGOtJnt8
	fpMF4LWx8U+JhOzcUe3TUj4K+k9TP9RPkstPn+lpje43gODu0jT/dqyNxSx23L5sAq0iWA9j6ts
	68mazkY4+cO7bAS5tY+hVBc2PW9wUtYXeTksX55p3llRLDhg/MPJd4E7x+n3M6y5ziNXVjI9v5L
	PtgOtQVzeOUfqAvy5dDioMS0tnsVVSCBV4QGBLGIQ==
X-Received: by 2002:a05:620a:370e:b0:8cf:d953:b4f1 with SMTP id af79cd13be357-8e78f72ffd4mr1870500885a.1.1776693061842;
        Mon, 20 Apr 2026 06:51:01 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e7d69abee3sm790342385a.17.2026.04.20.06.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 06:51:01 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Steve French <sfrench@samba.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	linux-cifs@vger.kernel.org
Cc: Paulo Alcantara <pc@manguebit.org>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Bharath SM <bharathsm@microsoft.com>,
	samba-technical@lists.samba.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] smb: client: require a full NFS mode SID before reading mode bits
Date: Mon, 20 Apr 2026 09:50:58 -0400
Message-ID: <20260420135058.469990-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[manguebit.org,gmail.com,microsoft.com,talpey.com,lists.samba.org,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-239230-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 13D5742D90A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

parse_dacl() treats an ACE SID matching sid_unix_NFS_mode as an NFS
mode SID and reads sid.sub_auth[2] to recover the mode bits.

That assumes the ACE carries three subauthorities, but compare_sids()
only compares min(a, b) subauthorities.  A malicious server can return
an ACE with num_subauth = 2 and sub_auth[] = {88, 3}, which still
matches sid_unix_NFS_mode and then drives the sub_auth[2] read four
bytes past the end of the ACE.

Require num_subauth >= 3 before treating the ACE as an NFS mode SID.
This keeps the fix local to the special-SID mode path without changing
compare_sids() semantics for the rest of cifsacl.

Fixes: e2f8fbfb8d09 ("cifs: get mode bits from special sid on stat")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 fs/smb/client/cifsacl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/smb/client/cifsacl.c b/fs/smb/client/cifsacl.c
index c920039d733c..a62c8a733779 100644
--- a/fs/smb/client/cifsacl.c
+++ b/fs/smb/client/cifsacl.c
@@ -831,6 +831,7 @@ static void parse_dacl(struct smb_acl *pdacl, char *end_of_acl,
 			dump_ace(ppace[i], end_of_acl);
 #endif
 			if (mode_from_special_sid &&
+			    ppace[i]->sid.num_subauth >= 3 &&
 			    (compare_sids(&(ppace[i]->sid),
 					  &sid_unix_NFS_mode) == 0)) {
 				/*
-- 
2.53.0


