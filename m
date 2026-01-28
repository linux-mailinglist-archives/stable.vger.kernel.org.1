Return-Path: <stable+bounces-212662-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QLaoBn5cemm35QEAu9opvQ
	(envelope-from <stable+bounces-212662-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 19:59:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B55EA7FEE
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 19:59:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 146F73035D63
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 18:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0A1350A30;
	Wed, 28 Jan 2026 18:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="pfv/pxwT"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f193.google.com (mail-dy1-f193.google.com [74.125.82.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB8F313520
	for <stable@vger.kernel.org>; Wed, 28 Jan 2026 18:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769626747; cv=none; b=mg+wYHM6DPE2pbH0kk3EHzmiiUxePXv5TMQueYZ3K+c5gPsvEeyRg5XZIlQ9fFNw2IXeTLduGkJK2VKqcji7gZfHsqHiJeMbvfIrVaAvFL5+0GyFEXPxRsbsAsv7cynOAGD/6Jc+DwSCi26/W2NVbqBfZYcWz4jb5F5ASlcd7aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769626747; c=relaxed/simple;
	bh=kOHkqzbMq7qzJ7DQzP2qllMA9SvSS1txt22NfUufw9M=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=raNPaNJU4H44JQMh527qoIMPp+1CbKMxmvscpHwk/li3hJRZM0g8nvHy7fPRFs77V4TKNdVcet9FQQKtG7mlLQth+aIEFkqKnT3It/g3g1i7Lg0u+mobrDkMOym6a5HGbKRAgbuRQJj7XJMt/cUW3XGeOhVkCRU6sSLJrKUcQcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=pfv/pxwT; arc=none smtp.client-ip=74.125.82.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-dy1-f193.google.com with SMTP id 5a478bee46e88-2b1981ca515so280895eec.1
        for <stable@vger.kernel.org>; Wed, 28 Jan 2026 10:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1769626745; x=1770231545; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0tKz0gxtMQFNX4V24OkEbuVzzp2fjgGzDGjGLRRNNfA=;
        b=pfv/pxwTaU39fUnghiOmb452zWGOIlllvlLrikeSZWGqeMceg4YSctxBvF4Y+aXqDI
         GtXXqC6AADg3dNvteVO+km/oyUe68yiUU+zKE9kGhgQHChZOUnh6sZEKrOJUNIA7w4hS
         823BAS1nck5TdP2oTVstjT91gcyLZjyxJqNRF+gPSZ74yC5Hk38xI++OLN1w9Bp9oLBW
         ubJiGHhKIjwqpqRjCAQeR9BcB5xqoLnpFM3vXUb9ha5fXx2kJLHnsCzUYjmaYKEl8bEk
         3JvXShZKjr4yg66B9mNfNmXyGq/LLPZ/F70VasPEhUkawK5dT2Nq0JMRPTxftOU7a+Tc
         ovXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769626745; x=1770231545;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0tKz0gxtMQFNX4V24OkEbuVzzp2fjgGzDGjGLRRNNfA=;
        b=QpXpV1skWG3mXR3AGU5AqqxXNLmpiTFa0bUaG9b7sIQo7tgLJ6kuOvzgkbG/BPSPoN
         zPKcIsobSFaIrH7q2Fzafu4NasaxTwdut2WYcur5rukjWv0R+MqsIpevuztwicjLtWau
         hrv1ck5/Zgb3bqmqup5D46e19PFiajmQj1jkA66jQZ9OUHq1JgOaJOSncEkjBC2ndbjR
         YYsfYuHQs9L/KfOAhNC3cEp2bDdJTcDpga2T4zZN/JCFYkrypJb5XhzIUSHfySREEcCu
         q8rW3vYMZYCK4HDZj/P59yF82EruqnCoOfxk937o+5+icJBp/tyGshA3SupcfyfNO5HT
         n+kA==
X-Forwarded-Encrypted: i=1; AJvYcCXahYFklG48rpfJQD9B0Rudb04vkZJbqAnjpGrsMYk8eQke9jzWpVpMDJ6Afus1/DSPuZiiXIM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBo5nydl3YrOHSfEKTrOsDaqLZAv4R8sJW2zbNL7z9ndPPR1q7
	Jr/+gP8NsNRWfCgl6D+QU/cnan2Kpsweel1m15d9BiI9NkBxTa62qAOxPKyLN9cHW0s3zvceXMQ
	Z+u13YFo=
X-Gm-Gg: AZuq6aLJUusZR44g9swkxc6XK+A2pMt6PerZZePGvIOqY8BswtblpghOBMRq0Yz2zDs
	ksEVC9/539KSofylYX4MGzLp/IocyRUHKeoisQ44CDTZAJyoc3OS3HgX5OjG2OdC49YW7uXrl6b
	DpFMkHeezN2J+B4N4pMtOGiCkpw1I3MaNDDVJclmZwxsvnJ009Skl/aUBr9z3kHTGxRMh7QjBAh
	N7AUAm0GxMU3BhYlgpD0Zz4qE0LPl/LerJb3qfACp51buLyLmHSSS1wnJ6eJ6G+HQuu1muAj6BI
	WFUSaYX+AcugSkK7LhqAAuTh01ZxEdWfB7bDsX7CcY9QS9JVOxqPzBxaoZusasreDhzLcrRXY4y
	xTU4AqzBhxdVMbbMXPlK5Gurepj62zIlNVA+YJ8LL9Rd1b2Dtr1iCmHLBtHGMZZOZ2OzE+ZbhR3
	4yur3+
X-Received: by 2002:a05:7300:dc14:b0:2b0:6a03:e620 with SMTP id 5a478bee46e88-2b78d9fdc33mr3876716eec.24.1769626744633;
        Wed, 28 Jan 2026 10:59:04 -0800 (PST)
Received: from 22d5995788c3 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7a16cfaa8sm3685826eec.4.2026.01.28.10.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 10:59:03 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-5.10.y: (build) passing 'const void *'
 to
 parameter of type 'void *' discards qual...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Wed, 28 Jan 2026 18:59:03 -0000
Message-ID: <176962674334.3769.2151907495073629925@22d5995788c3>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://files.kernelci.org/kbuild-clang-21-i386-allmodconfig-697a296b1908a6300d9ba36f/.config];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernelci-org.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-212662-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[kernelci.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bot@kernelci.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernelci-org.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	HAS_REPLYTO(0.00)[kernelci@lists.linux.dev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email,kernelci.org:url,kernelci.org:email,kernelci-org.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 6B55EA7FEE
X-Rspamd-Action: no action





Hello,

New build issue found on stable-rc/linux-5.10.y:

---
 passing 'const void *' to parameter of type 'void *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers] in drivers/net/bonding/bond_main.o (drivers/net/bonding/bond_main.c) [logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/i/maestro:98842e43083cea8565d90b0299d8137e4a217c13
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  4eafbd6b7c0c9f7c63aba0ded0cfcfe0ee9a5868


Please include the KernelCI tag when submitting a fix:

Reported-by: kernelci.org bot <bot@kernelci.org>


Log excerpt:
=====================================================
drivers/net/bonding/bond_main.c:3653:66: error: passing 'const void *' to parameter of type 'void *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
 3653 |                 fk->ports.ports = __skb_flow_get_ports(skb, *nhoff, *ip_proto, data, hlen);
      |                                                                                ^~~~
./include/linux/skbuff.h:1291:14: note: passing argument to parameter 'data' here
 1291 |                             void *data, int hlen_proto);
      |                                   ^
drivers/net/bonding/bond_main.c:3696:32: error: passing 'const void *' to parameter of type 'void *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
 3696 |                                           &flow_keys_bonding, fk, data,
      |                                                                   ^~~~
./include/linux/skbuff.h:1311:10: note: passing argument to parameter 'data' here
 1311 |                         void *data, __be16 proto, int nhoff, int hlen,
      |                               ^
drivers/net/bonding/bond_main.c:3713:41: error: passing 'const void *' to parameter of type 'void *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
 3713 |                 skb_flow_get_icmp_tci(skb, &fk->icmp, data, nhoff, hlen);
      |                                                       ^~~~
./include/net/flow_dissector.h:371:13: note: passing argument to parameter 'data' here
  371 |                            void *data, int thoff, int hlen);
      |                                  ^
  CC [M]  drivers/net/ethernet/freescale/fman/fman_dtsec.o
3 errors generated.

=====================================================


# Builds where the incident occurred:

## defconfig+allmodconfig on (arm64):
- compiler: clang-21
- config: https://files.kernelci.org/kbuild-clang-21-arm64-allmodconfig-697a29371908a6300d9ba33d/.config
- dashboard: https://d.kernelci.org/build/maestro:697a29371908a6300d9ba33d

## i386_defconfig+allmodconfig+CONFIG_FRAME_WARN=2048 on (i386):
- compiler: clang-21
- config: https://files.kernelci.org/kbuild-clang-21-i386-allmodconfig-697a296b1908a6300d9ba36f/.config
- dashboard: https://d.kernelci.org/build/maestro:697a296b1908a6300d9ba36f


#kernelci issue maestro:98842e43083cea8565d90b0299d8137e4a217c13

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

