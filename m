Return-Path: <stable+bounces-192629-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C62C3C36D
	for <lists+stable@lfdr.de>; Thu, 06 Nov 2025 17:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AD7B3BB501
	for <lists+stable@lfdr.de>; Thu,  6 Nov 2025 15:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4BB340A63;
	Thu,  6 Nov 2025 15:56:59 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D42E26ED55
	for <stable@vger.kernel.org>; Thu,  6 Nov 2025 15:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762444619; cv=none; b=GQqc9sr02sMUPVGf6F+wKg6bTXHfiXp0D6oiteP9a7zYfEWXCjQJ6AywMWGVvtDfI5pV/6FK8JVwi5Tmef00eebsh9/SqsY+LbvFoJvi4bvk3zlBWcUJLRccvq+HH3Ng9DEfhAdzJGpQoT8vaucYXgNULWoWLSZkxDliEprOMAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762444619; c=relaxed/simple;
	bh=rOrZ/4A04kwhL0ic9QR0izswFHe9Y3mAQqCArP6A188=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JMlIW5s9bSup0dXco54O00114m4dGVoLtATW6Tp+/b1TuRl59F7Ctesr2wc8DFNNTM0l+qPSL9a5N3VwVP4gj7+YHKcrJ7dkbDBevDP0t0SgYQHk5LFLyNDvP910vgHXMXpA83jt8sljdMdqt2/uD3z8IDsYB+9fXAThLn4Vn9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-640b0639dabso2294174a12.3
        for <stable@vger.kernel.org>; Thu, 06 Nov 2025 07:56:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762444616; x=1763049416;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+PmoYhmQszxefHjhkpT3KQeYOeoKqB+UgwTp/bM0o7s=;
        b=hHbrX80wZhn8etiCneGB5oyyCUrdW0atJQJsNj6CylP/UROtomk5JduF14E2Vqx43C
         KaPLbWyVKrdNFHOyYZYNxm0BggYI+KQ3gE4M3r4mxNj2jkstQV8hGUm0EwDVmFekFBwa
         EoPEdjpIS1TarOOXUhFFpufC/R3b7ei8iYYnyArCnn24HIscFPIjYpB098aBGEFcdUT+
         XZqQlRdvUGUcieX/rC8/oV55C3gG2f2hwCLfuTqoA7DnTx0GHy66zm7Gg0O7kSICbc28
         kifrsJNNF+p994trfKRpseJwR9QCchfIadBuDijPlA1Pf7ezhxFFu+Q5iPVf85x+z2KS
         UfVA==
X-Forwarded-Encrypted: i=1; AJvYcCWUG6b65WUzWb5XSp5yU+l1PgXXOEH49ZI3N7H2h0Bhn+BbLzAqP4Q04DiczV6kxhO1CkuJU1w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw28Zse7TNzIGRofiM2NabWOtWzQ6Ft2aNxMxIGDaqJCO56agDG
	oDuP1MZmG1HxaH2WDXaM7tkBBaVQgHOLRaZdT7mVK4MCRrFuqTMhLLiG
X-Gm-Gg: ASbGncvk4F6WY4WMtANjfKM3B8zvvswkCu3C+fgeNcE0vgIoDZMvORC9dTdlSJMjWpa
	FjxM6kKjCmP7DEzIBx6rYxuJI5VnOrfNzkZnDYYdWfeHL9ClA4i40ZUIrXfk3IWOulkGFfrv1PD
	koFjhkXOuyoEhUcfIZjYMxITLqeXM637oPLGswx0v6oJhAOGRhOTE5/pn96OC/9r0+tmZnhxsEB
	CdOBG9CsCnTpFFyUNWhhMKRrdj9u8cIb36/DUAER4Bwwalsj5UqE1Cg8n9yEqYacBAV1phA3Au9
	jpM2KE6OCRAvtazCOOJv2TVJ9vDA/9rXHr3PzX3twgj/miRftzRPPkN03u+TEIBPL+nR/h0BLv9
	PYNMr475oh1sTrYE4VSnsaM1X62yQaM4Td5lYBX5XEVe94/GvNqHMMg13gYnTZPhYHHo=
X-Google-Smtp-Source: AGHT+IGtUCnY/0gL5xUXSuNGqI8E7ELQM5g8O42ZsyJXJ0jZ2YG8OSfxqQDMKV4oFHPUZ8QwMLmBOw==
X-Received: by 2002:a17:907:1c0a:b0:b28:b057:3958 with SMTP id a640c23a62f3a-b726554c3d8mr890156866b.48.1762444615548;
        Thu, 06 Nov 2025 07:56:55 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:73::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72a2824c2asm132004266b.34.2025.11.06.07.56.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 07:56:55 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH net v9 0/4] net: netpoll: fix memory leak and add
 comprehensive selftests
Date: Thu, 06 Nov 2025 07:56:46 -0800
Message-Id: <20251106-netconsole_torture-v9-0-f73cd147c13c@debian.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD/FDGkC/33RTWrDMBAF4KsYrTNl9C951XuUUiR5lAiKHWTXt
 ATfvcSL1sVO1wPfPN67sZFqoZG1zY1VmstYhp61jT81LF1CfyYoHWsbJlBo9CigpykN/Ti809s
 01OmjErichMwYUvCenRp2rZTL54q+sJ4m9npq2KWM01C/1kczX0//mTMHDiiTQWO0d+SfO4ol9
 E9DPa/eLLaGOjQEIGhrNXW6S9KYnSG3hj40JCA4q5PNFDvJ94baGNweGgoQMOgoo8uOJ9oZemu
 4Q0MDgrUkNGFQFPc5zI/B8UGn5t6HkjFrkU1Ue8NuDXloWEAIwYucEhkR9ru4X4M/2MXdcwjnl
 EISOeAfY1mWb/1CxiSWAgAA
X-Change-ID: 20250902-netconsole_torture-8fc23f0aca99
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
 david decotigny <decot@googlers.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, asantostc@gmail.com, efault@gmx.de, 
 calvin@wbinvd.org, kernel-team@meta.com, calvin@wbinvd.org, 
 jv@jvosburgh.net, Breno Leitao <leitao@debian.org>, stable@vger.kernel.org
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=3370; i=leitao@debian.org;
 h=from:subject:message-id; bh=rOrZ/4A04kwhL0ic9QR0izswFHe9Y3mAQqCArP6A188=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpDMVFwKvvzkebqNy/kZS1nG85335bRbP4s/Pu5
 IU2Ck7/bKmJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaQzFRQAKCRA1o5Of/Hh3
 bQSgEACQ1IzCyzKXtsX1G1SQIUxRdM5w4WuZXB37xspJkRXQoQTcPBeg+oSGeBu94hWm4DByKnB
 nb+1MdF3FXpbqlybrKyL6i28j2T3EhcB+G7rDdaAQ3uINsgGqElQRcPOA+Sn8ufuor2Qt899iBA
 MSsgTzJUzJ+OA3gIci+ub104ujlJCRszUiI9n3uQtZp2Me0hbVyXe+EOpFMOzLB0vwHRWiP/eqT
 JnZnyC9/3mIradwD7dLP7Its2eqC0s8siUnnjUItzeHJ3lFwJl2bp2cYTplZKA6GurnBzSujtOR
 At0z69SADJ5seIywWNs7bOsKKmSq9snvcl6HXsWICe7zIMFrG1FPzIMek3O4N48gayrk9ZTcOPJ
 jOOLgSsxA2sPvLKQaqiiSYOV7I2ethrpy9aap6zasMyGy7axv6wJfJ1TQRYWST1xbun1xv0fxlH
 tsfrzxoIMfRoLTfjla7pad1iy9US+u81V2N0QdMNTdfb0GX6uhlDdR4BNON/mzS7T8JWogV4ZwP
 56L6JB+ygDB3AzaIDOm6FTuH8opSklHolK5oIfvjPFd1MZ1GzkzF3VaJ+tN9aI884cl1yup9rVM
 pDry9PYPHFeRggKwwL5zgbOXTotyepzEznTjh6yGgIEuhrMpSeeRctXHtfyJ9wtQ5xP3RcZT17F
 GY8ZdsemENBPBJw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Fix a memory leak in netpoll and introduce netconsole selftests that
expose the issue when running with kmemleak detection enabled.

This patchset includes a selftest for netpoll with multiple concurrent
users (netconsole + bonding), which simulates the scenario from test[1]
that originally demonstrated the issue allegedly fixed by commit
efa95b01da18 ("netpoll: fix use after free") - a commit that is now
being reverted.

Sending this to "net" branch because this is a fix, and the selftest
might help with the backports validation.

Link: https://lore.kernel.org/lkml/96b940137a50e5c387687bb4f57de8b0435a653f.1404857349.git.decot@googlers.com/ [1]

Signed-off-by: Breno Leitao <leitao@debian.org>
---
Changes in v9:
- Reordered the config entries in tools/testing/selftests/drivers/net/bonding/config (NIPA)
- Link to v8: https://lore.kernel.org/r/20251104-netconsole_torture-v8-0-5288440e2fa0@debian.org

Changes in v8:
- Sending it again, now that commit 1a8fed52f7be1 ("netdevsim: set the
  carrier when the device goes up") has landed in net
- Created one namespace for TX and one for RX (Paolo)
- Used additional helpers to create and delete netdevsim (Paolo)
- Link to v7: https://lore.kernel.org/r/20251003-netconsole_torture-v7-0-aa92fcce62a9@debian.org

Changes in v7:
- Rebased on top of `net`
- Link to v6: https://lore.kernel.org/r/20251002-netconsole_torture-v6-0-543bf52f6b46@debian.org

Changes in v6:
- Expand the tests even more and some small fixups
- Moved the test to bonding selftests
- Link to v5: https://lore.kernel.org/r/20250918-netconsole_torture-v5-0-77e25e0a4eb6@debian.org

Changes in v5:
- Set CONFIG_BONDING=m in selftests/drivers/net/config.
- Link to v4: https://lore.kernel.org/r/20250917-netconsole_torture-v4-0-0a5b3b8f81ce@debian.org

Changes in v4:
- Added an additional selftest to test multiple netpoll users in
  parallel
- Link to v3: https://lore.kernel.org/r/20250905-netconsole_torture-v3-0-875c7febd316@debian.org

Changes in v3:
- This patchset is a merge of the fix and the selftest together as
  recommended by Jakub.

Changes in v2:
- Reuse the netconsole creation from lib_netcons.sh. Thus, refactoring
  the create_dynamic_target() (Jakub)
- Move the "wait" to after all the messages has been sent.
- Link to v1: https://lore.kernel.org/r/20250902-netconsole_torture-v1-1-03c6066598e9@debian.org

---
Breno Leitao (4):
      net: netpoll: fix incorrect refcount handling causing incorrect cleanup
      selftest: netcons: refactor target creation
      selftest: netcons: create a torture test
      selftest: netcons: add test for netconsole over bonded interfaces

 net/core/netpoll.c                                 |   7 +-
 tools/testing/selftests/drivers/net/Makefile       |   1 +
 .../testing/selftests/drivers/net/bonding/Makefile |   2 +
 tools/testing/selftests/drivers/net/bonding/config |   4 +
 .../drivers/net/bonding/netcons_over_bonding.sh    | 361 +++++++++++++++++++++
 .../selftests/drivers/net/lib/sh/lib_netcons.sh    |  82 ++++-
 .../selftests/drivers/net/netcons_torture.sh       | 130 ++++++++
 7 files changed, 569 insertions(+), 18 deletions(-)
---
base-commit: 7d1988a943850c584e8e2e4bcc7a3b5275024072
change-id: 20250902-netconsole_torture-8fc23f0aca99

Best regards,
--  
Breno Leitao <leitao@debian.org>


