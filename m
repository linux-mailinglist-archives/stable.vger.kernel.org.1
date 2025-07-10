Return-Path: <stable+bounces-161603-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1F9B0069A
	for <lists+stable@lfdr.de>; Thu, 10 Jul 2025 17:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AE623A8289
	for <lists+stable@lfdr.de>; Thu, 10 Jul 2025 15:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D3E271447;
	Thu, 10 Jul 2025 15:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kWAhMXMO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1B622E3FA
	for <stable@vger.kernel.org>; Thu, 10 Jul 2025 15:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752161257; cv=none; b=DjESd04QipcrUSeeyHndXitOXPkb3Ce1T+DbcKgvr7AOXJxA/mpAAHrhLtUZoHy2vhp3sEH0aRNRNlGbGZdapiMqeG0PwQXMKE2xgED/9sNXoqS/FO2Y21zP27tk0oE2SmSs4xUq2Eti1SGCLCaSXh3LZtu3qSpns7Y7zSZEGP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752161257; c=relaxed/simple;
	bh=crsf61AExplo++XZ8gLgiWfSfD1X1uxx8M6PFqPjoWM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rmLVwbPuZs8Uuo6w+T6NQ8ZiguIXQXWhDQdmTq01p1e/a8Wu+/GefhqcWiwS1fwwXyGt18WNaFBiBs2/SQaAw958H7c20+sgqKHna67JjGstIsrsq0fCvhMghWGy+PDnoeCoMcbC4G6i4lT2brkfAFcKu1GhsRGYFixF2PoXLwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kWAhMXMO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29F02C4CEE3;
	Thu, 10 Jul 2025 15:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752161257;
	bh=crsf61AExplo++XZ8gLgiWfSfD1X1uxx8M6PFqPjoWM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kWAhMXMOeaukBW13yiHXDdI6kLk57xVpn4PSCEPuq5mp0HoBJLk9rbkbD9tFyxW4l
	 jKo2kRJHpG9axzcrAYchk8khZvSBJAHBI96vGh5g+fUjKuYx5v/b45Gf3climUY3KN
	 R7sef92/01VCOZc4K2l0HgduGtcq3j8SRf+T4FvIBA0f9BRtmP6DNMYM2CwMZ1vJH7
	 iNYiWdKURpAdnQVI70oXKlrU8sAG5mkqhgQe0Yvi/MPyjjmd9MQoosfYDD7LYuGKAv
	 MJ1Nu/8601G1vSorRoAsEQIdbGeMOqjuS45XN2U24VQwmTedhQ/LCb5nHadFSSkfj8
	 7llVpiZSbYb5w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Eggers <ceggers@arri.de>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y v2] Bluetooth: HCI: Set extended advertising data synchronously
Date: Thu, 10 Jul 2025 11:27:35 -0400
Message-Id: <20250709082432-54f63a70d53ba090@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250709090551.9089-2-ceggers@arri.de>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

✅ All tests passed successfully. No issues detected.
No action required from the submitter.

The upstream commit SHA1 provided is correct: 89fb8acc38852116d38d721ad394aad7f2871670

Status in newer kernel trees:
6.15.y | Present (different SHA1: db2d6aa98a23)
6.12.y | Present (different SHA1: 6e5dc6c4581c)

Note: The patch differs from the upstream commit:
---
1:  89fb8acc38852 ! 1:  2986967377cd5 Bluetooth: HCI: Set extended advertising data synchronously
    @@ Metadata
      ## Commit message ##
         Bluetooth: HCI: Set extended advertising data synchronously
     
    +    commit 89fb8acc38852116d38d721ad394aad7f2871670 upstream.
    +
    +    [This patch deviates from the upstream version because 3 functions in
    +    hci_sync.c (hci_set_ext_adv_data_sync, hci_set_adv_data_sync and
    +    hci_update_adv_data_sync) had to be moved up within the file. The
    +    content of these functions differs between 6.6 and newer kernels.]
    +
         Currently, for controllers with extended advertising, the advertising
         data is set in the asynchronous response handler for extended
         adverstising params. As most advertising settings are performed in a
    @@ net/bluetooth/hci_sync.c: static int hci_set_adv_set_random_addr_sync(struct hci
     +
     +static int hci_set_ext_adv_data_sync(struct hci_dev *hdev, u8 instance)
     +{
    -+	DEFINE_FLEX(struct hci_cp_le_set_ext_adv_data, pdu, data, length,
    -+		    HCI_MAX_EXT_AD_LENGTH);
    ++	struct {
    ++		struct hci_cp_le_set_ext_adv_data cp;
    ++		u8 data[HCI_MAX_EXT_AD_LENGTH];
    ++	} pdu;
     +	u8 len;
     +	struct adv_info *adv = NULL;
     +	int err;
     +
    ++	memset(&pdu, 0, sizeof(pdu));
    ++
     +	if (instance) {
     +		adv = hci_find_adv_instance(hdev, instance);
     +		if (!adv || !adv->adv_data_changed)
     +			return 0;
     +	}
     +
    -+	len = eir_create_adv_data(hdev, instance, pdu->data,
    -+				  HCI_MAX_EXT_AD_LENGTH);
    ++	len = eir_create_adv_data(hdev, instance, pdu.data);
     +
    -+	pdu->length = len;
    -+	pdu->handle = adv ? adv->handle : instance;
    -+	pdu->operation = LE_SET_ADV_DATA_OP_COMPLETE;
    -+	pdu->frag_pref = LE_SET_ADV_DATA_NO_FRAG;
    ++	pdu.cp.length = len;
    ++	pdu.cp.handle = instance;
    ++	pdu.cp.operation = LE_SET_ADV_DATA_OP_COMPLETE;
    ++	pdu.cp.frag_pref = LE_SET_ADV_DATA_NO_FRAG;
     +
     +	err = __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_EXT_ADV_DATA,
    -+				    struct_size(pdu, data, len), pdu,
    ++				    sizeof(pdu.cp) + len, &pdu.cp,
     +				    HCI_CMD_TIMEOUT);
     +	if (err)
     +		return err;
    @@ net/bluetooth/hci_sync.c: static int hci_set_adv_set_random_addr_sync(struct hci
     +	if (adv) {
     +		adv->adv_data_changed = false;
     +	} else {
    -+		memcpy(hdev->adv_data, pdu->data, len);
    ++		memcpy(hdev->adv_data, pdu.data, len);
     +		hdev->adv_data_len = len;
     +	}
     +
    @@ net/bluetooth/hci_sync.c: static int hci_set_adv_set_random_addr_sync(struct hci
     +
     +	memset(&cp, 0, sizeof(cp));
     +
    -+	len = eir_create_adv_data(hdev, instance, cp.data, sizeof(cp.data));
    ++	len = eir_create_adv_data(hdev, instance, cp.data);
     +
     +	/* There's nothing to do if the data hasn't changed */
     +	if (hdev->adv_data_len == len &&
    @@ net/bluetooth/hci_sync.c: int hci_le_terminate_big_sync(struct hci_dev *hdev, u8
      
     -static int hci_set_ext_adv_data_sync(struct hci_dev *hdev, u8 instance)
     -{
    --	DEFINE_FLEX(struct hci_cp_le_set_ext_adv_data, pdu, data, length,
    --		    HCI_MAX_EXT_AD_LENGTH);
    +-	struct {
    +-		struct hci_cp_le_set_ext_adv_data cp;
    +-		u8 data[HCI_MAX_EXT_AD_LENGTH];
    +-	} pdu;
     -	u8 len;
     -	struct adv_info *adv = NULL;
     -	int err;
     -
    +-	memset(&pdu, 0, sizeof(pdu));
    +-
     -	if (instance) {
     -		adv = hci_find_adv_instance(hdev, instance);
     -		if (!adv || !adv->adv_data_changed)
     -			return 0;
     -	}
     -
    --	len = eir_create_adv_data(hdev, instance, pdu->data,
    --				  HCI_MAX_EXT_AD_LENGTH);
    +-	len = eir_create_adv_data(hdev, instance, pdu.data);
     -
    --	pdu->length = len;
    --	pdu->handle = adv ? adv->handle : instance;
    --	pdu->operation = LE_SET_ADV_DATA_OP_COMPLETE;
    --	pdu->frag_pref = LE_SET_ADV_DATA_NO_FRAG;
    +-	pdu.cp.length = len;
    +-	pdu.cp.handle = instance;
    +-	pdu.cp.operation = LE_SET_ADV_DATA_OP_COMPLETE;
    +-	pdu.cp.frag_pref = LE_SET_ADV_DATA_NO_FRAG;
     -
     -	err = __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_EXT_ADV_DATA,
    --				    struct_size(pdu, data, len), pdu,
    +-				    sizeof(pdu.cp) + len, &pdu.cp,
     -				    HCI_CMD_TIMEOUT);
     -	if (err)
     -		return err;
    @@ net/bluetooth/hci_sync.c: int hci_le_terminate_big_sync(struct hci_dev *hdev, u8
     -	if (adv) {
     -		adv->adv_data_changed = false;
     -	} else {
    --		memcpy(hdev->adv_data, pdu->data, len);
    +-		memcpy(hdev->adv_data, pdu.data, len);
     -		hdev->adv_data_len = len;
     -	}
     -
    @@ net/bluetooth/hci_sync.c: int hci_le_terminate_big_sync(struct hci_dev *hdev, u8
     -
     -	memset(&cp, 0, sizeof(cp));
     -
    --	len = eir_create_adv_data(hdev, instance, cp.data, sizeof(cp.data));
    +-	len = eir_create_adv_data(hdev, instance, cp.data);
     -
     -	/* There's nothing to do if the data hasn't changed */
     -	if (hdev->adv_data_len == len &&
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

