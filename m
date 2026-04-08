Return-Path: <stable+bounces-235221-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cP5MIRyr1mmZHAgAu9opvQ
	(envelope-from <stable+bounces-235221-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 21:23:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C34853C2DED
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 21:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 14214322B753
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 19:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91953D9DAF;
	Wed,  8 Apr 2026 19:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="a2LITPdJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99B232692B;
	Wed,  8 Apr 2026 19:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775674881; cv=none; b=nW5z2xEKI3GtTrER7YlIyguMEQTGKy4GJ/wF5VOS5zG2lWkfXOl+1hE0/0bpw9CRFTYeWNCZKj/ikOFrusnjyyq0I6DDQV6DIokNT51Z93oI3xglvrCUgFArsEgDO1dXW/RAtOOpeaf4/O6jkqxoZwLNw5ysUGN9fZ72vbr7rrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775674881; c=relaxed/simple;
	bh=CxH7cOICM5Kcq+50rqL3IMOP/A7fIxBPWU8z33QWo2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RGyFjfStLOYZYjOdZ1tmzf2N+FEw3+B43qdvulJ77E/O7Px+488QOclGnJ9OWwRUnJl8CncI52NiZoZ/zM6FMWFg3yYvL5YlxwJeIqCGjnqwiUKoTc/bbZAwBOIEeKQRGAuVKs+5IbyP1Jn3+SNMgbwKXW/Olc98ZyFm6i1xzz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=a2LITPdJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DB30C19421;
	Wed,  8 Apr 2026 19:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775674881;
	bh=CxH7cOICM5Kcq+50rqL3IMOP/A7fIxBPWU8z33QWo2E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a2LITPdJ3t5etK9Pcy0AcKf/+ZqOLqxLIiVpn8dcKai7nKNlJ4PSWq3OxnWPbMnwY
	 DsFgBBojT57wCjhj9xZK5uYFq4zhVZNWizKzMeWoUi8o9pWt7NyOHMdeI+tGyqahXp
	 qd/ecDgcoruLWGyoDobJMjKtUv70tjOLWGT56Lf4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Arnd Bergmann <arnd@arndb.de>,
	kernel test robot <lkp@intel.com>,
	stable <stable@kernel.org>,
	Dave Penkler <dpenkler@gmail.com>
Subject: [PATCH 6.19 269/311] gpib: Fix fluke driver s390 compile issue
Date: Wed,  8 Apr 2026 20:04:29 +0200
Message-ID: <20260408175949.427297132@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175939.393281918@linuxfoundation.org>
References: <20260408175939.393281918@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,arndb.de,intel.com,kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-235221-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,arndb.de:email]
X-Rspamd-Queue-Id: C34853C2DED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dave Penkler <dpenkler@gmail.com>

commit 579af7204d762587f9cce0d6236a710a771f1f6f upstream.

The following errors were reported for a s390 randconfig build
of the fluke gpib driver:

>> drivers/gpib/eastwood/fluke_gpib.c:1002:23: error: call to undeclared function 'ioremap'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1002 |         nec_priv->mmiobase = ioremap(e_priv->gpib_iomem_res->start,
         |                              ^
>> drivers/gpib/eastwood/fluke_gpib.c:1002:21: error: incompatible integer to pointer conversion assigning to 'void *' from 'int' [-Wint-conversion]
    1002 |         nec_priv->mmiobase = ioremap(e_priv->gpib_iomem_res->start,
         |                            ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    1003 |                                      resource_size(e_priv->gpib_iomem_res));
         |                                      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpib/eastwood/fluke_gpib.c:1036:33: error: incompatible integer to pointer conversion assigning to 'void *' from 'int' [-Wint-conversion]
    1036 |         e_priv->write_transfer_counter = ioremap(e_priv->write_transfer_counter_res->start,
         |                                        ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    1037 |                                                  resource_size(e_priv->write_transfer_counter_res));
         |                                                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Add HAS_IOMEM dependency to Kconfig for fluke driver option

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202601221748.AFAqHieJ-lkp@intel.com/
Fixes: baf8855c9160 ("staging: gpib: fix address space mixup")
Cc: stable <stable@kernel.org>
Signed-off-by: Dave Penkler <dpenkler@gmail.com>
Link: https://patch.msgid.link/20260202094755.4259-1-dpenkler@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpib/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/gpib/Kconfig
+++ b/drivers/gpib/Kconfig
@@ -122,6 +122,7 @@ config GPIB_FLUKE
 	depends on OF
        select GPIB_COMMON
        select GPIB_NEC7210
+       depends on HAS_IOMEM
        help
          GPIB driver for Fluke based cda devices.
 



