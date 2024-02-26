Return-Path: <stable+bounces-23700-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE8286768D
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 14:29:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C41B1C29628
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 13:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13792128390;
	Mon, 26 Feb 2024 13:29:02 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047BF128368
	for <stable@vger.kernel.org>; Mon, 26 Feb 2024 13:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708954141; cv=none; b=dg7QBr1jhI/MdpMeyE8nKvcXn/ND3BBViP+XkNSEaJU6/Fkgdp/Orbves7RfmyDXbDJAsRskM/np842dFL8i72jJhCbTFBFQ4aMWgZFqaTH5WIXPOkAE5DUimLh4vSC6B7kWvh64uCwx4C+cIW9/VQPCX5RUrby3v+pIwODk3gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708954141; c=relaxed/simple;
	bh=4sYJJ6QnoUvArjDTWoJIs3vCFujHmMChwqYv5bkaAEo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iXuOdSlzwo1n+bMhm56Q7NCicOdASYXLeFVF5MqrttzLFahCli16wsNFS833jaGgtZCOD/na5lFIfwvSCpqgNsKUTRGHBHAo9nw2nDhQ3gC7ORtPVMfXvhYddvjETfcMP7NMSCJzy8ZUSUGPmpMAJj3lyWGVOfHYDDosFfI+8vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: by air.basealt.ru (Postfix, from userid 490)
	id 7E28C2F2024E; Mon, 26 Feb 2024 13:28:56 +0000 (UTC)
X-Spam-Level: 
Received: from taut9powder.malta.altlinux.ru (obninsk.basealt.ru [217.15.195.17])
	by air.basealt.ru (Postfix) with ESMTPSA id B74A22F20238;
	Mon, 26 Feb 2024 13:28:54 +0000 (UTC)
From: Alexander Ofitserov <oficerovas@altlinux.org>
To: oficerovas@altlinux.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Pauli Virtanen <pav@iki.fi>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	kovalev@altlinux.org,
	nickel@altlinux.org,
	dutyrok@altlinux.org
Subject: [PATCH 0/2] possible deadlock in sco_conn_del
Date: Mon, 26 Feb 2024 16:28:35 +0300
Message-Id: <20240226132837.8404-1-oficerovas@altlinux.org>
X-Mailer: git-send-email 2.33.8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This bug was found by syzkaller. This series of patches
is fix for this particular bug. Both of these patches were taken
from upstream and applied clearly without any conflicts.
First one is the fix for the problem
and another one is for fix first patch.

Luiz Augusto von Dentz (1):
  Bluetooth: SCO: Fix possible circular locking dependency on
    sco_connect_cfm

Pauli Virtanen (1):
  Bluetooth: SCO: fix sco_conn related locking and validity issues

 net/bluetooth/sco.c | 76 ++++++++++++++++++++++++++-------------------
 1 file changed, 44 insertions(+), 32 deletions(-)

-- 
2.42.1


