Return-Path: <stable+bounces-172772-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C5BEB3347E
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 05:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A19913B98EF
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 03:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B08001F2BB8;
	Mon, 25 Aug 2025 03:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="Eg/EtFSH"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF57F28E7
	for <stable@vger.kernel.org>; Mon, 25 Aug 2025 03:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756092651; cv=none; b=mqVFC3PhkzW4ICE/tNPErZTKHB+azS4hSxIhaKB07c/Q++hweMVL02TZ1VMjc8I0WVni4NvwhmpcWGiMupG8WACtQr7TjHNtivfBmq1/gPHCq0/WlfM2CE9TgroHCHBIcsHOovQkju0wtFdThjpvSdql27xCJo6Jm12dteRVuBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756092651; c=relaxed/simple;
	bh=20Ly0v4mf5I3GvJq4vdI6Ezg4VLhRM+gZjB7CZkqRY8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ltQGCsz5c0RIg0jY/CDwhShPk5fUNP6/KVGCHLLflLH1I5peQeCP3dlcY/HGvgdexj2AjCpunMXcyL3dzczi2FRsdadTsBFCdFAvKTEKaX1FC7WsqawxoKRFXGwNJehagVCUhvaG8EYQbcv6CLR9nUU2CnmDqBR4GC4OYISq3TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=Eg/EtFSH; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-246648f833aso11389805ad.3
        for <stable@vger.kernel.org>; Sun, 24 Aug 2025 20:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1756092649; x=1756697449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WOG7Pn5iOjR9eaz+H8Eol5Ftxa06sNkeSd4gzYS0v7s=;
        b=Eg/EtFSH3FTcYKGvQ7moCCddvsH1/2HWXHuG+EryC58U8H+9VmUpsPdykFZMisb+40
         ff1SaNaTq0a0Qnhy93U1LrUlHsxefCah6SZf/Ep0P4Ca3VbN6561VaIMO9418P0h2RLZ
         EFx/EdsXFfQ5dcqwsHfrL3asa+9HZnreroEXxrafpfGGGrmkH8tflaJjlTq35IIANogk
         /rm/gQmIxiGGij1j7NtOKg2Zuzb3BA4ex6s3GuqsL+7n+93EiLGJ12adiOYUIF2eOpf4
         s/CnoRxW9GuyiIkQCPxZB5xBUM7sshIaM8zbEbXWx0YtVsHuNhHy33MSykrZ4mkCPI4D
         HB2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756092649; x=1756697449;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WOG7Pn5iOjR9eaz+H8Eol5Ftxa06sNkeSd4gzYS0v7s=;
        b=mKrLzyhUJyzW+tHpnphjJvavtqVWGc7LrIIpWZ2skWgbRIL3cK4u2i+htNb1Rj9e9e
         f6ycfHrPm4WSqTxjMqiaQHJLo5qqroDuqhFS5A95v0Fn+NBudKDkKtAjavTQWPlnUScs
         jGrCXc+Fwg8YTlBMlQo3JNYWVEkVtspYpQ3ccXZuR103HJDKbzWZ9hxVblnTz9O3YPnn
         O/kH3NWAoUZLrzvQ29Ip+dmAN4ssYVtVugpfTqzEZBhEkkNeU1YG7jVcxvcgiydYY8k4
         ODg1OFxeWIY3AAUlWwVoe1ewFoykYqRKeaZnRVqVwd+7HelWJLI0InNag+eXte9ZWm1k
         uW0A==
X-Gm-Message-State: AOJu0Yw+OSIi/OL1F5Zb+cpC43xmQPjqmd6zne52mJFODVtWRSu3q8uB
	08QaddhhTE+BR0W7Vxxf3BFi+SpK5mCxCk2+goWDWZCGtygniXaqsV0t6dG+zolOgT+VdXSZibI
	PeegM5XM=
X-Gm-Gg: ASbGncvRq0eblSe8G6N7YBvH0vt21tjwVEp3ZKYIBwwyr8Na7V5ksiWLbZ1BX+Kybwr
	9UN0kLwEJzuWCKRoyMlx3tO3IHCgooz0geyLKTyBKIAy4ta/id64STJcnvKV2qqkqxnziGzwRtg
	FKEEBLtkDEd/qKzDXutxUL7uckFNR4h7yI+tR4XfP6jTeDTFO+pSDZ+xu7iLcVtBQVRfr+91mXj
	xmRnOFq/aCNTfmAWz/5OfGMkWFF6pHNEAs7DxruIzi+Z44PYu5cIL/afrNlaOK7gvPqq9me8GJW
	RX8BAjigFTWlBglWjsCgcODh40BFKMCoGl15Gc86xFIfIyc1H7gv0P7ZCdpaNIapQR2YQ/2ogYQ
	2vwc+DNu5+gOb+u2Scvti0Rj1
X-Google-Smtp-Source: AGHT+IGvcaAkL3l4PMeONMCzfeiQBSuzJcoTy2Iz5VXJqSXE8Bv8ULxvPsZwU4/I4xcnfIxM1AZCKw==
X-Received: by 2002:a17:903:2ad0:b0:246:b93b:9739 with SMTP id d9443c01a7336-246b93b9d0bmr30873635ad.22.1756092648980;
        Sun, 24 Aug 2025 20:30:48 -0700 (PDT)
Received: from mozart.vkv.me ([192.184.167.117])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b49d2f0206dsm4214150a12.48.2025.08.24.20.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 20:30:48 -0700 (PDT)
From: Calvin Owens <calvin@wbinvd.org>
To: stable@vger.kernel.org
Cc: jedrzej.jagielski@intel.com,
	anthony.l.nguyen@intel.com,
	David.Kaplan@amd.com,
	dhowells@redhat.com,
	kyle.leet@gmail.com
Subject: [PATCH 6.16.y 1/2] devlink: let driver opt out of automatic phys_port_name generation
Date: Sun, 24 Aug 2025 20:30:13 -0700
Message-ID: <20597f81c1439569e34d026542365aef1cedfb00.1756088250.git.calvin@wbinvd.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>

[ Upstream commit c5ec7f49b480db0dfc83f395755b1c2a7c979920 ]

Currently when adding devlink port, phys_port_name is automatically
generated within devlink port initialization flow. As a result adding
devlink port support to driver may result in forced changes of interface
names, which breaks already existing network configs.

This is an expected behavior but in some scenarios it would not be
preferable to provide such limitation for legacy driver not being able to
keep 'pre-devlink' interface name.

Add flag no_phys_port_name to devlink_port_attrs struct which indicates
if devlink should not alter name of interface.

Suggested-by: Jiri Pirko <jiri@resnulli.us>
Link: https://lore.kernel.org/all/nbwrfnjhvrcduqzjl4a2jafnvvud6qsbxlvxaxilnryglf4j7r@btuqrimnfuly/
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: stable@vger.kernel.org # 6.16
Tested-By: Calvin Owens <calvin@wbinvd.org>
Signed-off-by: Calvin Owens <calvin@wbinvd.org>
---
 include/net/devlink.h | 6 +++++-
 net/devlink/port.c    | 2 +-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/net/devlink.h b/include/net/devlink.h
index 0091f23a40f7..af3fd45155dd 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -78,6 +78,9 @@ struct devlink_port_pci_sf_attrs {
  * @flavour: flavour of the port
  * @split: indicates if this is split port
  * @splittable: indicates if the port can be split.
+ * @no_phys_port_name: skip automatic phys_port_name generation; for
+ *		       compatibility only, newly added driver/port instance
+ *		       should never set this.
  * @lanes: maximum number of lanes the port supports. 0 value is not passed to netlink.
  * @switch_id: if the port is part of switch, this is buffer with ID, otherwise this is NULL
  * @phys: physical port attributes
@@ -87,7 +90,8 @@ struct devlink_port_pci_sf_attrs {
  */
 struct devlink_port_attrs {
 	u8 split:1,
-	   splittable:1;
+	   splittable:1,
+	   no_phys_port_name:1;
 	u32 lanes;
 	enum devlink_port_flavour flavour;
 	struct netdev_phys_item_id switch_id;
diff --git a/net/devlink/port.c b/net/devlink/port.c
index 939081a0e615..cb8d4df61619 100644
--- a/net/devlink/port.c
+++ b/net/devlink/port.c
@@ -1519,7 +1519,7 @@ static int __devlink_port_phys_port_name_get(struct devlink_port *devlink_port,
 	struct devlink_port_attrs *attrs = &devlink_port->attrs;
 	int n = 0;
 
-	if (!devlink_port->attrs_set)
+	if (!devlink_port->attrs_set || devlink_port->attrs.no_phys_port_name)
 		return -EOPNOTSUPP;
 
 	switch (attrs->flavour) {
-- 
2.47.2


