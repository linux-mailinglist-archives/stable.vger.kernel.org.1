Return-Path: <stable+bounces-16667-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1850B840DEC
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 18:13:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3C142868D6
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 17:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97D215DBA4;
	Mon, 29 Jan 2024 17:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aoJxQRMh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879E315956B;
	Mon, 29 Jan 2024 17:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706548189; cv=none; b=dn4jueBN3TCSh04vlr1odcJdFzfhG4ot0tZZlCObM7krdcOEL17CidvZsRBvhzXcuoLbmbv1JbZL105QwtlLf2nHBZq1zRW/9DRsVArTQp7p+4PQiPa/LGfodeE1H+u+66QhH/zO1qe7KEBgICPQPA3EJPqZPR4VfKYqfZmGMgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706548189; c=relaxed/simple;
	bh=9c4Z9h1NwJL2lMJvdwLriDXhh68tAxWWnzmG0fO/aJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=brSW3FBWoLICWFB4x9urVmaMvU0dQsJH/ZEmCRkIRaYq6zJsNR2QutRCB0grYw/8FnMMAOpBo3hxeE5IC2EPFxEKxRcst0peFR7ZTiQUbYYYXr2sB7T50Tb2Z0v/jeAnOj4yE6rozrH+Xv/I9nUkryhsCC7/oXhueRV4mQjgcRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aoJxQRMh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1215FC43390;
	Mon, 29 Jan 2024 17:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706548189;
	bh=9c4Z9h1NwJL2lMJvdwLriDXhh68tAxWWnzmG0fO/aJk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aoJxQRMhUw1TqMxeoWmigjiA6Cg11/Q9ndAebuAPoHGbalgsMgwVOnw6nV3Z2nqbo
	 Y/d6SHifdxFxFqV5L5YGlE2HxqWI6VlYCam+9TaKTxkiullEW6UsO7FQjujGaPwjJx
	 GDElq1Y4+aB0azFkq5qijX2fCvdMf1por072qqpI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 205/346] selftests: netdevsim: fix the udp_tunnel_nic test
Date: Mon, 29 Jan 2024 09:03:56 -0800
Message-ID: <20240129170022.425453422@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129170016.356158639@linuxfoundation.org>
References: <20240129170016.356158639@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit 0879020a7817e7ce636372c016b4528f541c9f4d ]

This test is missing a whole bunch of checks for interface
renaming and one ifup. Presumably it was only used on a system
with renaming disabled and NetworkManager running.

Fixes: 91f430b2c49d ("selftests: net: add a test for UDP tunnel info infra")
Acked-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://lore.kernel.org/r/20240123060529.1033912-1-kuba@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../selftests/drivers/net/netdevsim/udp_tunnel_nic.sh    | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/netdevsim/udp_tunnel_nic.sh b/tools/testing/selftests/drivers/net/netdevsim/udp_tunnel_nic.sh
index 1b08e042cf94..185b02d2d4cd 100755
--- a/tools/testing/selftests/drivers/net/netdevsim/udp_tunnel_nic.sh
+++ b/tools/testing/selftests/drivers/net/netdevsim/udp_tunnel_nic.sh
@@ -269,6 +269,7 @@ for port in 0 1; do
 	echo 1 > $NSIM_DEV_SYS/new_port
     fi
     NSIM_NETDEV=`get_netdev_name old_netdevs`
+    ifconfig $NSIM_NETDEV up
 
     msg="new NIC device created"
     exp0=( 0 0 0 0 )
@@ -430,6 +431,7 @@ for port in 0 1; do
     fi
 
     echo $port > $NSIM_DEV_SYS/new_port
+    NSIM_NETDEV=`get_netdev_name old_netdevs`
     ifconfig $NSIM_NETDEV up
 
     overflow_table0 "overflow NIC table"
@@ -487,6 +489,7 @@ for port in 0 1; do
     fi
 
     echo $port > $NSIM_DEV_SYS/new_port
+    NSIM_NETDEV=`get_netdev_name old_netdevs`
     ifconfig $NSIM_NETDEV up
 
     overflow_table0 "overflow NIC table"
@@ -543,6 +546,7 @@ for port in 0 1; do
     fi
 
     echo $port > $NSIM_DEV_SYS/new_port
+    NSIM_NETDEV=`get_netdev_name old_netdevs`
     ifconfig $NSIM_NETDEV up
 
     overflow_table0 "destroy NIC"
@@ -572,6 +576,7 @@ for port in 0 1; do
     fi
 
     echo $port > $NSIM_DEV_SYS/new_port
+    NSIM_NETDEV=`get_netdev_name old_netdevs`
     ifconfig $NSIM_NETDEV up
 
     msg="create VxLANs v6"
@@ -632,6 +637,7 @@ for port in 0 1; do
     fi
 
     echo $port > $NSIM_DEV_SYS/new_port
+    NSIM_NETDEV=`get_netdev_name old_netdevs`
     ifconfig $NSIM_NETDEV up
 
     echo 110 > $NSIM_DEV_DFS/ports/$port/udp_ports_inject_error
@@ -687,6 +693,7 @@ for port in 0 1; do
     fi
 
     echo $port > $NSIM_DEV_SYS/new_port
+    NSIM_NETDEV=`get_netdev_name old_netdevs`
     ifconfig $NSIM_NETDEV up
 
     msg="create VxLANs v6"
@@ -746,6 +753,7 @@ for port in 0 1; do
     fi
 
     echo $port > $NSIM_DEV_SYS/new_port
+    NSIM_NETDEV=`get_netdev_name old_netdevs`
     ifconfig $NSIM_NETDEV up
 
     msg="create VxLANs v6"
@@ -876,6 +884,7 @@ msg="re-add a port"
 
 echo 2 > $NSIM_DEV_SYS/del_port
 echo 2 > $NSIM_DEV_SYS/new_port
+NSIM_NETDEV=`get_netdev_name old_netdevs`
 check_tables
 
 msg="replace VxLAN in overflow table"
-- 
2.43.0




