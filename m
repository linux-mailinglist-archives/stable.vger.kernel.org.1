Return-Path: <stable+bounces-28663-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EFC7887D65
	for <lists+stable@lfdr.de>; Sun, 24 Mar 2024 16:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D92A8B20BC6
	for <lists+stable@lfdr.de>; Sun, 24 Mar 2024 15:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B4A318030;
	Sun, 24 Mar 2024 15:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="kaS+7ubC"
X-Original-To: stable@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE46CA64
	for <stable@vger.kernel.org>; Sun, 24 Mar 2024 15:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711292774; cv=none; b=VWHXKSCTpK8NfPZQ0OXjJE5xcqGY7eiYjIV6hugISPAuD9B7i7mOWeq9hkpw0bLi8zHnBvMKxEpJ0zZm6EjLorCakYtHp8F3XdZABMjugczvWKMDe4U5t7qgVa4DdIsEm2jjzwn9yRGGHu9+zADOFuOvc+zUUzesryYEdtr5OLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711292774; c=relaxed/simple;
	bh=qJHPRM2gdys+820o4wcDBtZ+Cqvv4dQSl3hjBTRlRf8=;
	h=MIME-Version:Date:From:To:Subject:Message-ID:Content-Type; b=H89YOwNMyboaF/Z1j1t2w+54by3IsrciCZaPx2edsK60E4KY3J/Hd6Y+yy1BTFTfXOfS/ebO/x8W8o57DyMV1c4ADPP94pTASshucyKaYKYmQjvjNQXmjM2OteHAs2RITEMy878XvSxHU/4pT9f7wugTD+2WnMHOh1LpwMtFct0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=kaS+7ubC; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 816611BF204
	for <stable@vger.kernel.org>; Sun, 24 Mar 2024 15:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1711292769;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HOQcTr9Fo+nc7qiFLE0MjN4Z4xV5yrXKHMZcVD8ctKQ=;
	b=kaS+7ubCwmIYcQCHsai8QWYV5r+PXs1UwgeGiNrlha4shQ5so09Ba5Ys5PoRVnOrfZC6wM
	d1l4RzpZhFqoelZV+kMhhZCRiN2lEB8UJElNQ+X33BB0jqSufPcd+JYg6uI39yGjzOcrJi
	k7fGMnqjiPX0ykj8CZIMohySgEZ3r983ABhkA1xWMJoZ3HuHnbgus1P7YIZ1zHLL5emv5I
	bVGlqh9UF4Xdweajlaz9F10dUmm2Al5kvlc387T1W+OLU0HfhcLHeopayNwpu9sQdBVGh3
	umiSinnprlLeNLQdMi0ZQ3Aedj4fNgv35T1lNFRZrm0wI+mnIhPUomNbf/tpdA==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 24 Mar 2024 18:06:09 +0300
From: arinc.unal@arinc9.com
To: stable@vger.kernel.org
Subject: Please apply these to 6.8, 6.7, 6.6, 6.1, and 5.15 stable
Message-ID: <173e61b8-4302-451b-b78f-b19e4ab76c14@arinc9.com>
X-Sender: arinc.unal@arinc9.com
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

Hi.

Please apply these patches in this order. They fully resolve the issues
with link-local frames on the switches the MT7530 DSA subdriver 
controls.
The commits apply to all stable trees as is.

To 5.15:

8332cf6fd7c7 net: dsa: mt7530: fix handling of LLDP frames
e94b590abfff net: dsa: mt7530: fix handling of 802.1X PAE frames
e8bf353577f3 net: dsa: mt7530: fix link-local frames that ingress vlan 
filtering ports
69ddba9d170b net: dsa: mt7530: fix handling of all link-local frames

To 6.8, 6.7, 6.6, 6.1:

e8bf353577f3 net: dsa: mt7530: fix link-local frames that ingress vlan 
filtering ports
69ddba9d170b net: dsa: mt7530: fix handling of all link-local frames

Arınç

