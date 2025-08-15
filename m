Return-Path: <stable+bounces-169771-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03525B2845D
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 18:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06745AE069D
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 16:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F792E5D35;
	Fri, 15 Aug 2025 16:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="jNIwGicV"
X-Original-To: stable@vger.kernel.org
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248FE2E5D14
	for <stable@vger.kernel.org>; Fri, 15 Aug 2025 16:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755276518; cv=none; b=Pz3fNNaH1MMaq5FbEj1yfk8bThfRpyO5C78nb9vsae5YvCxe9uYfhwMv6qQPBUGfNtcg3wZOZq/FueNeJ5TEJOduf/+024etvl5HVFZwStimvPATy0HsOLTlBM2gVPLrznu4kMUp6dXiFnqFmMRdF/qGqLRKiXEKI931wOnAy+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755276518; c=relaxed/simple;
	bh=2L6F6V4SJOY27ls+ZrHaQQ1KrtJ4MCsKiRDBN3ZRkZ0=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID; b=sJwQQ/pb48+5Io9LHNb1A38J8vzlVuZG1HQjg63iKzi4DMqIP7fyPFXT5vgp7uTnuEM+0qr1Z7uA3+WkCFwaIddNF4GcD/U5lFEUuGOosLdthVwfF63tVqS6vN3LXkzPh1kU+bbEwl2BZndM+yTaURogat7y3sNP7yzuzko69lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=jNIwGicV; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1755276496;
	bh=2L6F6V4SJOY27ls+ZrHaQQ1KrtJ4MCsKiRDBN3ZRkZ0=;
	h=From:To:Subject:Mime-Version:Date:Message-ID;
	b=jNIwGicV6l6XSwFF51LQZ23F8hc8ZDk9Or3MW+hpfT+XkUpPyY7iS4UUNe10wlji7
	 LRXGjxrxZTOx9QDMu3X1hjQEGIEyJhvwdc2rho0fsWzWQKQEps0baEaaRhb+XMYVLQ
	 ODYtDKarO+FavtiiH8vnquVTU3ZKHgXB+hOtCgmM=
EX-QQ-RecipientCnt: 2
X-QQ-GoodBg: 1
X-QQ-SSF: 00400000000000F0
X-QQ-FEAT: D4aqtcRDiqST8P4pfj07qGG6ZowgZlQrBrKFg+dHp6U=
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-Originating-IP: STQY5oYZzdsKc3lt7a4dTEcZHjA+pQNeJ2tuVq6Jhcw=
X-QQ-STYLE: 
X-QQ-mid: lv3sz3a-6t1755276495tef538caf
From: "=?utf-8?B?V2VudGFvIEd1YW4=?=" <guanwentao@uniontech.com>
To: "=?utf-8?B?c3RhYmxl?=" <stable@vger.kernel.org>
Cc: "=?utf-8?B?Z3JlZ2to?=" <gregkh@linuxfoundation.org>
Subject: [PATCH 6.6] sched/fair: Fix frequency selection for non-invariant case
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Sat, 16 Aug 2025 00:48:14 +0800
X-Priority: 3
Message-ID: <tencent_07D4D9EB5CEA414A085CA5C3@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
X-BIZMAIL-ID: 17105409648277821311
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
	by smtp.qq.com (ESMTP) with SMTP
	id ; Sat, 16 Aug 2025 00:48:16 +0800 (CST)
Feedback-ID: lv:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: Mp5a/kwQRzyIJY72d/hxIDwo72otSKD+QVJ/UeVXI50u6zSVZJb9ucHD
	thUWL3e+8c39DURpiGz1XiFxMovO9rpFF690B5h1+iwG8/4e1/2/diydxfA0wiisNpncXb6
	FCnbyEIQGWWJrx4phPlFeD8hLA9Z/jW1qL2Byh/kLXAFsYQtl/zZxLCxY7edDfjicRhMrVU
	FZ6/DJfFIafOKRuWqmjaFjRngfTuiH2IJAGe7stqjGr4X3SyFHLnvTr+jD1KI7nGh11rDbh
	GlCIFbe5emfCSnJH54OmdFCWRv4pNAUA1SSHlwC76D1PZmjEHR1Umftlmk0hSQcdoPTKecO
	7/RwCOjosgoJY05gLrO2rv6kku9wH26CBdkqaWb1vHFzH8HHCQOLeRoFl1QHw33PCacQFeM
	Z2O37UAvCC+eBE9zeO+ZbYyHfMJyxxZ+lrk0GDL/oorNdxx7G/cVKyLOCJsVNjKU1owN8Fv
	J5MdSvDsSlszI/eFKW/uljp+UPIcy4W65TYBLK6XrAIzm+6enb80G6nh/uq/m/N/1UtE+9m
	XrPcLmKPdXWNL+GMsQnTqneZh77xsnrKjnPxHoTUb5h3sU0hgvHzxdpNXXlzjodl9oU6yCO
	/10DnYTx8u/6jMEYj2uSMHEuJkD06WCHBhHdJdl7VgH7p6vjNsYpsEwDqUGxJ8VzacgOPJT
	M3RqflirkUNqBArhRL7ymsZF0fwyr20uXx7VTNGUroRplHQtg4mthUwjTaydbjGnayeXmUY
	ePQHgBAMPZ0SshneXGavbjvIompOJnWycur08iI5XKoSD3B1fC6CMYuLllSA3j2NAKpMwWA
	4SpJz2Xdi3wkiTCYGwU5K7zeUSqQMjB1qWgrKwz9n16Egz6hRQG5owZm95wIXxhdfdlznZ1
	J4T7RRO8ZW+spqXLnI/YvEgTxrzeIRg5KaNUtFEB/y7+XJZgsTKXWS4zF0rp/di2VNb0SGu
	a98YKeG3m6mXzFifu6jCsnzziNGtvH6a5tLvCVDwRDmK3NmOhiAB4Ruv+DTlffCPGQ00URE
	DYghWKSMzEApFXSTOQ
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0

SGksDQogICAgUGxlYXNlIGFwcGx5IHRoZSBjb21taXQgZTM3NjE3YzhlNTNhMWY3ZmNiYTZk
NWUxMDQxZjRmZDhhMjQyNWMyNywNCml0IGZpeCB0aGUgUkVHUkVTU0lPTiBieSBhZGE4ZDdm
YTBhZDQ5YTJhMDc4Zjk3ZjdmNmUwMmQyNGQzYzM1N2EzDQooInNjaGVkL2NwdWZyZXE6IFJl
d29yayBzY2hlZHV0aWwgZ292ZXJub3IgcGVyZm9ybWFuY2UgZXN0aW1hdGlvbiIpIHdoaWNo
DQppbnRyb2R1Y2VkIGluIHY2LjYuODkuDQoNCkJlc3QgUmVnYXJkcw0KV2VudGFvIEd1YW4=


