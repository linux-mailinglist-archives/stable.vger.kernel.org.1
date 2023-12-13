Return-Path: <stable+bounces-5729-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1363880D627
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 19:31:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 451901C2158B
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 18:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5CD45103D;
	Mon, 11 Dec 2023 18:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KgDbfZw5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8854174A;
	Mon, 11 Dec 2023 18:31:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 160C1C433C7;
	Mon, 11 Dec 2023 18:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702319508;
	bh=nspoN+6z6S/5FksqQGy0v/F7oAGb4ZdLbUp50OcOe7c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KgDbfZw5unDWvBcmM5OSp/tYvqYf4x7vkQOXDng50sS1XZlbwtMKWfKxtmDJezmB7
	 LnHgn4JYxBoHOEZZO201DICfFp9UbwKZMQYebruWoPo+YLeUog0Cw4SwOui1usblan
	 FrCybXOriLZ1VMdLOcvthuNGcjTAOwL7OMjNu/dg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Kieran Bingham <kbingham@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 131/244] scripts/gdb: fix lx-device-list-bus and lx-device-list-class
Date: Mon, 11 Dec 2023 19:20:24 +0100
Message-ID: <20231211182051.685078200@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211182045.784881756@linuxfoundation.org>
References: <20231211182045.784881756@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Fainelli <florian.fainelli@broadcom.com>

[ Upstream commit 801a2b1b49f4dcf06703130922806e9c639c2ca8 ]

After the conversion to bus_to_subsys() and class_to_subsys(), the gdb
scripts listing the system buses and classes respectively was broken, fix
those by returning the subsys_priv pointer and have the various caller
de-reference either the 'bus' or 'class' structure members accordingly.

Link: https://lkml.kernel.org/r/20231130043317.174188-1-florian.fainelli@broadcom.com
Fixes: 7b884b7f24b4 ("driver core: class.c: convert to only use class_to_subsys")
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
Tested-by: Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Kieran Bingham <kbingham@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 scripts/gdb/linux/device.py | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/scripts/gdb/linux/device.py b/scripts/gdb/linux/device.py
index 16376c5cfec64..0eabc5f4f8ca2 100644
--- a/scripts/gdb/linux/device.py
+++ b/scripts/gdb/linux/device.py
@@ -36,26 +36,26 @@ def for_each_bus():
     for kobj in kset_for_each_object(gdb.parse_and_eval('bus_kset')):
         subsys = container_of(kobj, kset_type.get_type().pointer(), 'kobj')
         subsys_priv = container_of(subsys, subsys_private_type.get_type().pointer(), 'subsys')
-        yield subsys_priv['bus']
+        yield subsys_priv
 
 
 def for_each_class():
     for kobj in kset_for_each_object(gdb.parse_and_eval('class_kset')):
         subsys = container_of(kobj, kset_type.get_type().pointer(), 'kobj')
         subsys_priv = container_of(subsys, subsys_private_type.get_type().pointer(), 'subsys')
-        yield subsys_priv['class']
+        yield subsys_priv
 
 
 def get_bus_by_name(name):
     for item in for_each_bus():
-        if item['name'].string() == name:
+        if item['bus']['name'].string() == name:
             return item
     raise gdb.GdbError("Can't find bus type {!r}".format(name))
 
 
 def get_class_by_name(name):
     for item in for_each_class():
-        if item['name'].string() == name:
+        if item['class']['name'].string() == name:
             return item
     raise gdb.GdbError("Can't find device class {!r}".format(name))
 
@@ -70,13 +70,13 @@ def klist_for_each(klist):
 
 
 def bus_for_each_device(bus):
-    for kn in klist_for_each(bus['p']['klist_devices']):
+    for kn in klist_for_each(bus['klist_devices']):
         dp = container_of(kn, device_private_type.get_type().pointer(), 'knode_bus')
         yield dp['device']
 
 
 def class_for_each_device(cls):
-    for kn in klist_for_each(cls['p']['klist_devices']):
+    for kn in klist_for_each(cls['klist_devices']):
         dp = container_of(kn, device_private_type.get_type().pointer(), 'knode_class')
         yield dp['device']
 
@@ -103,7 +103,7 @@ class LxDeviceListBus(gdb.Command):
     def invoke(self, arg, from_tty):
         if not arg:
             for bus in for_each_bus():
-                gdb.write('bus {}:\t{}\n'.format(bus['name'].string(), bus))
+                gdb.write('bus {}:\t{}\n'.format(bus['bus']['name'].string(), bus))
                 for dev in bus_for_each_device(bus):
                     _show_device(dev, level=1)
         else:
@@ -123,7 +123,7 @@ class LxDeviceListClass(gdb.Command):
     def invoke(self, arg, from_tty):
         if not arg:
             for cls in for_each_class():
-                gdb.write("class {}:\t{}\n".format(cls['name'].string(), cls))
+                gdb.write("class {}:\t{}\n".format(cls['class']['name'].string(), cls))
                 for dev in class_for_each_device(cls):
                     _show_device(dev, level=1)
         else:
-- 
2.42.0




