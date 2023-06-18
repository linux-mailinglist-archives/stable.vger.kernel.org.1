Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD397345E9
	for <lists+stable@lfdr.de>; Sun, 18 Jun 2023 13:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbjFRLnH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 18 Jun 2023 07:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjFRLnG (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 18 Jun 2023 07:43:06 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC511E5E
        for <stable@vger.kernel.org>; Sun, 18 Jun 2023 04:43:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TA44trTeCoKzg8QPGXaAOqdJPia2Mk/up/h6N8cDohLMFGtnwepR8Q2GyzC/C73cA3mhBIFMRYn/K+IZI14TlpKs4JsJTS1kmNcLsai7UbktCssdzqGzp95zsl61pLHkidUL8uNTrng7mm6rIpgsoBKwUJ+AX73y43rx+seFhGdQD2O4dF+kde+i8aZAsaHTWBqdaoSpvsjx5jKopUTrhTGgBLqi6lWxrfE/iSBDSbb+n3oFOjmhlFqt+uGnifHcj0/cRXu/PUz14Ho5A0ViGg38sgxSxOewD/KFB/Bh3VvmT1IDHhkddglst6XDu5JeIrI1vNbDriOaaXLj8P4LoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fMVXBGr1jt9Se/CbrMpDMGQs5tLbkadAmstqV/2Hdz4=;
 b=RN76XUdK73SDPGjtm7iYUUDiF3YC1lX71yuf0UXSn41nKcvWIign/Gia3nOTfzO+cqgq3oOD4c+98R/628z0n+s68iy/3Z+iattPuwYdfU4k6FP3hP+61YPVIzhQYrMoLjRmnc+fIR1+7vHDXJRg3P0nxVJ69lpqQzFp2xj8N4dfU4jGnocpr2q2dxxC+X1AviQsKp9ziERYNkqNxE01H5Z3NlzDpMcPyjmwOsm00Qv+GSTg4NJ3KlxXp/3zG3keEmtfqenHmcWol7UWbYagfh22dJeJ7vh4XjJCuogLeKXtavv7ttaX/cvlTtHYWHSfmJcSchKLwViTPnbmqBCrsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=infinera.com; dmarc=pass action=none header.from=infinera.com;
 dkim=pass header.d=infinera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infinera.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fMVXBGr1jt9Se/CbrMpDMGQs5tLbkadAmstqV/2Hdz4=;
 b=HNb/kj+hMSOE5Lw+z4LgKlhdPmvSd/TEYk1lof1GlIyhaY3ujS9zWn+FZV2NMgZvG9dj2d9j0+qrzC+IxFB6IVNz4UE3dOxMF8pROVaK7lMl886g0gIBV4x9WLhTpeiFWcfpZxooa6mIoyItdRCNj53B2GBCDAqRE34JE7FBuX956xascMa4k9lwoP6KoGHcOreEBPv+MDL0PltrKZDlScrOUHzJ8teIopISRkNRlUPe/pbUkAj885eDNxEfxnld1qS3EKRfBgR0QEJnj20dCJDMog08M4yDdsTE9zgJdfmKrKvyQOXWWjX3dW6RLGxHMkp3pn17TTcYyVMe4IxURA==
Received: from PH0PR10MB4615.namprd10.prod.outlook.com (2603:10b6:510:36::24)
 by CH2PR10MB4152.namprd10.prod.outlook.com (2603:10b6:610:79::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.35; Sun, 18 Jun
 2023 11:42:59 +0000
Received: from PH0PR10MB4615.namprd10.prod.outlook.com
 ([fe80::f01a:585:8d6:3d3c]) by PH0PR10MB4615.namprd10.prod.outlook.com
 ([fe80::f01a:585:8d6:3d3c%7]) with mapi id 15.20.6500.031; Sun, 18 Jun 2023
 11:42:59 +0000
From:   Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "felipe.balbi@linux.intel.com" <felipe.balbi@linux.intel.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "romain.izard.pro@gmail.com" <romain.izard.pro@gmail.com>
Subject: Re: [PATCH 1/2] usb: gadget: f_ncm: Add OS descriptor support
Thread-Topic: [PATCH 1/2] usb: gadget: f_ncm: Add OS descriptor support
Thread-Index: AQHZk+YYeEDleSDzUkGuOQMGB6y2ZK+PQpqAgAEEt4CAACeuAIAAEpIAgAAKsoA=
Date:   Sun, 18 Jun 2023 11:42:59 +0000
Message-ID: <f9a5cb9abd407ee9f8b832e672c24d5bc5347c6b.camel@infinera.com>
References: <20230531173358.910767-1-joakim.tjernlund@infinera.com>
         <5533972aab4a15ab2177497edc9aa0ba1b97aaba.camel@infinera.com>
         <2023061854-daydream-outage-de91@gregkh>
         <afbf34e128a744bb37f8e533248b69c2b0fdff9e.camel@infinera.com>
         <2023061834-relative-gem-0d53@gregkh>
In-Reply-To: <2023061834-relative-gem-0d53@gregkh>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=infinera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB4615:EE_|CH2PR10MB4152:EE_
x-ms-office365-filtering-correlation-id: bf12d782-6275-40e3-e44c-08db6ff12aab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Vna0igwr+jVQspOftNdMehizZrLZ7VJSxhkr57spVCj0nuTxxc0ZdWnD+o3Md8QM7jQ5xJiEF0pNV3lAOUZJ9yV5f74C2icGoxu7mjVE7dnmuU4eM0REAntg5yYCArotWcFyKtTAlk9LMfYLrZhQzh5K4Tvpyx9pxzoPAs+cKWzW75jJWqeD/a4L+cYBv/t6zZ0StT5WSchhjCg8ZfXLJnBJ5308NqK6vNn5AQcvK+6jUGRMniszgd1pPjoyP+S2j0lCCK6/r1IH0+f0Q5iT34N9d0w0jgQiweX+bJ2BH5agYXyirh1Q1mQiTe0nft3VDVI2Uf346hUyxULXFai/X3oMUJ08v+lluLEqRSTaM15LG6tsSZwr2VsFtq/ZWgmS/p3GWbFhVYRRD+W/5pFtYwmqFVHFOSRbtlKeOKXo5nOt/MA44qcCWHUSTlXzNSN6Hi20CVyh8ZBmF0zcvu95CUMyC/srOn5kyg2HZgo58U8P2UyhmiMbNFiK5IMYtsomX91ovnSlaVaP0W3mDIViJN29HCC5/8q9MSJVj8UItYSRC57+qrFw3+f7Pvh2tldo7paasLkKZiOZAEbocpVI549vhSztt8V5ZvN9f9/TqsGGwyZTOtr8PhjE7EqbTySy
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4615.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(136003)(346002)(376002)(39850400004)(451199021)(45080400002)(86362001)(38100700002)(122000001)(478600001)(36756003)(38070700005)(8676002)(41300700001)(6486002)(8936002)(76116006)(91956017)(4326008)(54906003)(316002)(5660300002)(6506007)(186003)(2906002)(6512007)(6916009)(66946007)(71200400001)(66446008)(64756008)(66476007)(66556008)(83380400001)(2616005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S0NJb0R3WEdRVU9sSytRNnRUWG1zUHF5UjZsMS8wUTd2L01QVnE0MWJwcTV0?=
 =?utf-8?B?azE2S0JrMmRNUEhRVitIVGphWnNvcWxIOXdoNzBlVWRMaWdVSVFsNitEKy9q?=
 =?utf-8?B?UDJPUG9VRFRtQVhNTDY0UzlyZndWNGwyZmVOZDNYZzdzMmRIOUJUcEM2WURt?=
 =?utf-8?B?U2l4OFBmMnRPVXBoWWpveXl2SmZLamVxaGdqcmU3M2JTalFOOU83aDFwZmVU?=
 =?utf-8?B?cGNVa0NXajlKM3VWOVFGWExNbEpCZmcxWnRwNlMya00xd3VkelVnelhOd2NQ?=
 =?utf-8?B?UFM0eGQ0cllSaFBnQnc2eGtXRW9KdExCNVVNaTVuL2g0aXFRRlYvdmxaNWNa?=
 =?utf-8?B?VGN5cnF3eTBYU2lEUjZqck5ZNWMwUUNOTUpXT2FzYmFKN0NDVTlKMzFnaGpt?=
 =?utf-8?B?YWhTb2thTlhTUXlxK2NlQ0dadi9ORnpYNENDdFllVUV3U3AzSUVVYkVqQlFU?=
 =?utf-8?B?UnFFeU5TbXBpb01xRGhvck1WVkxGejVBdC9ZL2JHSHZ2Wk9QcFd6VFVheGU0?=
 =?utf-8?B?NFo1aWxWbFlzMWVmL0lTcXVvdTUzYUZXd05HVDZ4THhOSXkzZlNTbjkrTVp4?=
 =?utf-8?B?RDRrZmoxckM1V2VxeVlhakFyTjFIa09qSjk3TTNsaDdBbEJHMDV3MkhEOEZO?=
 =?utf-8?B?dlQvcFdzNkJxVVNubGhPRXBydEpZckdkQkp3QmdJMDNoRnlaVXgweUFQaUtk?=
 =?utf-8?B?TXRKVTJrdCtWcDBjN3pBVWE2dmQwZUwyM0oyM3lOSk10OW1ZSzJ5L3FIUGV1?=
 =?utf-8?B?RVVTZ0V2YWNMUitvMVNVQXB1UktVZnNFRmg4M3h4dXFPamY2RzkxN25pMFFr?=
 =?utf-8?B?V08zR1dXOW1keGJhdTdkR296aU5pMHorWHVCRjlMdmFTMUlJSytWTytabTBp?=
 =?utf-8?B?TVFDczBJYnhOOVV4UzB2dG5Mb0NZL0w3TzhDVDdtUkRmREZQZDBKUjhCWWVF?=
 =?utf-8?B?OVhGSGFiejJHK0lmRVcwdzdncEh4WGpwaXB6WmdkVmo0ajNTZTY3V2Z0NUxC?=
 =?utf-8?B?RUU0VHJwTWZrSTRGMnBjMVMxK1d1WFE5blgwNlU4cVh4d2hqd3grL1QwWkVD?=
 =?utf-8?B?OGgrdEI5cUZJTy9oRHByZk9UTXRjZldMQzd6eVhMQXlkTFFIajZRMUEwdENM?=
 =?utf-8?B?VDRnSFBBZWpuVDdVU2pnTklWVzBzcDJLa1VVZjhlYnNVZ2pab1Y1REhkRGJR?=
 =?utf-8?B?K0lybmQraFBmN0JIQTNTdHZsMFpiNDNFZm5kRGVVR0EyeG1sajNsUXdzRDM1?=
 =?utf-8?B?bUo1RWtKdFcrUkJyRWV1VTBmdTR0cWoxY1J5SUd5YTY2cGFySCtpamFIbE9x?=
 =?utf-8?B?QVI5WkZPQnNZR0N0SHpTREJrSEk3SWoxUW5TWkNDSlpDdFR3VThIQVIvS1hp?=
 =?utf-8?B?WSsxeXJqSTd6RTNYenlMNHB0YldURmViSWVqNTBXZmpKWG5IQzMzWWdDYXJC?=
 =?utf-8?B?Z0FQb0RzLzRDWHNQMjg5ZFNXMXN2MmlIR2pCVVFPaHIzTjNWSXRkOERZczFr?=
 =?utf-8?B?bzBSTVFjdGFmZDBvb3JSS3dSanNSbnMzK3BXN05oUTlKYklGVCtXKzF1OTBa?=
 =?utf-8?B?WWhJRFVlMmUyOFJoUnJsUnFmWVBTV1g4YlN4TUFtTTBrVDh0emZBSkJ2N3Vk?=
 =?utf-8?B?bmpxWGw0WTN6MHlzNWQ3czZ1R3hHK0JNN01xbVNuOWFCdzAwT01pbHdrU2pT?=
 =?utf-8?B?dXhsd0k0OUNPbklpWndTSFB6WldyVzdOV2dsTGh4ZXNCOUZsdWRCeUNzUFp6?=
 =?utf-8?B?czlETjNlWDcxaEZ2Q2pMdmVRZVlTa0pEU3NxMEs5YmJpRGFMS2EyaTRDM0hI?=
 =?utf-8?B?c0t0WkY3bm5SemxiOWlUbWtPR3hSUXRINkxFTkpGamdxVWEwOTFTZGtHNFFu?=
 =?utf-8?B?SWh3ajFaRXpOdk8rYUVFOEdadDJ1RENoejlKRTVkSzJCYVZqTDd4Slk4Z3hI?=
 =?utf-8?B?a0pORk9MeHpwaFBNN0o5cE11UmUwTXdMV0pUcEVxQlh1emZSdGoreGN3a2Nm?=
 =?utf-8?B?OVN2ZjhEYS9ra0U0d1pvNmxSK1FwcUZya1ZmM0gzbURjeEplK1M0QWRxWlVN?=
 =?utf-8?B?b0taSm1ScFFHQzJITS9DU3REV2xqNXVVL3Q5cVdIUzM0VVl6Y1dhTC9saDc4?=
 =?utf-8?B?QjRJUmlWRSswSWYxS2FWQ0hWUjNlejRZenc2SHBsbm5WSXZDZVkvWFV0MXlN?=
 =?utf-8?Q?RnNOubJRkgFsa1mgLDo0b8qYGNlsKmHMXZVNqFhTWyRu?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <37247A23E2AEAB49A86E4ECBF5CB522F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: infinera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4615.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf12d782-6275-40e3-e44c-08db6ff12aab
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2023 11:42:59.6672
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 285643de-5f5b-4b03-a153-0ae2dc8aaf77
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pFtB9OWJakk+VdvEJAzJhR5YVA24GcTrlazB4Pk+FBQ63WTZeeTW4R6W4+k+UNmFBOVDXTekVPXIX2Bzxwuplg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4152
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

T24gU3VuLCAyMDIzLTA2LTE4IGF0IDEzOjA0ICswMjAwLCBncmVna2hAbGludXhmb3VuZGF0aW9u
Lm9yZyB3cm90ZToNCj4gT24gU3VuLCBKdW4gMTgsIDIwMjMgYXQgMDk6NTg6MTRBTSArMDAwMCwg
Sm9ha2ltIFRqZXJubHVuZCB3cm90ZToNCj4gPiBPbiBTdW4sIDIwMjMtMDYtMTggYXQgMDk6MzYg
KzAyMDAsIEdyZWcgS0ggd3JvdGU6DQo+ID4gPiBPbiBTYXQsIEp1biAxNywgMjAyMyBhdCAwNDow
MzowNlBNICswMDAwLCBKb2FraW0gVGplcm5sdW5kIHdyb3RlOg0KPiA+ID4gPiBQaW5nID8NCj4g
PiA+ID4gDQo+ID4gPiA+IERpZCBJIGRvIHNvbWV0aGluZyB3cm9uZyB3aXRoIHN1Ym1pc3Npb24g
b3IgaXMgaXQgcXVldWVkIGZvciBsYXRlciA/DQo+ID4gPiA+IDQuMTkgaXMgbWlzc2luZyB0aGVz
ZSB3aGljaCBtYWtlIFVTQiBOQ00gdW51c2FibGUgd2l0aCBXaW4gPj0gMTAuIA0KPiA+ID4gPiAN
Cj4gPiA+ID4gIEpvY2tlDQo+ID4gPiA+IA0KPiA+ID4gPiBPbiBXZWQsIDIwMjMtMDUtMzEgYXQg
MTk6MzMgKzAyMDAsIEpvYWtpbSBUamVybmx1bmQgd3JvdGU6DQo+ID4gPiA+ID4gRnJvbTogUm9t
YWluIEl6YXJkIDxyb21haW4uaXphcmQucHJvQGdtYWlsLmNvbT4NCj4gPiA+ID4gPiANCj4gPiA+
ID4gPiBUbyBiZSBhYmxlIHRvIHVzZSB0aGUgZGVmYXVsdCBVU0IgY2xhc3MgZHJpdmVycyBhdmFp
bGFibGUgaW4gTWljcm9zb2Z0DQo+ID4gPiA+ID4gV2luZG93cywgd2UgbmVlZCB0byBhZGQgT1Mg
ZGVzY3JpcHRvcnMgdG8gdGhlIGV4cG9ydGVkIFVTQiBnYWRnZXQgdG8NCj4gPiA+ID4gPiB0ZWxs
IHRoZSBPUyB0aGF0IHdlIGFyZSBjb21wYXRpYmxlIHdpdGggdGhlIGJ1aWx0LWluIGRyaXZlcnMu
DQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gQ29weSB0aGUgT1MgZGVzY3JpcHRvciBzdXBwb3J0IGZy
b20gZl9ybmRpcyBpbnRvIGZfbmNtLiBBcyBhIHJlc3VsdCwNCj4gPiA+ID4gPiB1c2luZyB0aGUg
V0lOTkNNIGNvbXBhdGlibGUgSUQsIHRoZSBVc2JOY20gZHJpdmVyIGlzIGxvYWRlZCBvbg0KPiA+
ID4gPiA+IGVudW1lcmF0aW9uIHdpdGhvdXQgdGhlIG5lZWQgZm9yIGEgY3VzdG9tIGRyaXZlciBv
ciBpbmYgZmlsZS4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBSb21haW4g
SXphcmQgPHJvbWFpbi5pemFyZC5wcm9AZ21haWwuY29tPg0KPiA+ID4gPiA+IFNpZ25lZC1vZmYt
Ynk6IEZlbGlwZSBCYWxiaSA8ZmVsaXBlLmJhbGJpQGxpbnV4LmludGVsLmNvbT4NCj4gPiA+ID4g
PiBTaWduZWQtb2ZmLWJ5OiBKb2FraW0gVGplcm5sdW5kIDxqb2FraW0udGplcm5sdW5kQGluZmlu
ZXJhLmNvbT4NCj4gPiA+ID4gPiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZyAjIHY0LjE5DQo+
ID4gPiA+ID4gLS0tDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gIFNlZW1zIHRvIGhhdmUgYmVlbiBm
b3Jnb3R0ZW4gd2hlbiBiYWNrcG9ydGluZyBOQ00gZml4ZXMuDQo+ID4gPiA+ID4gIE5lZWRlZCB0
byBtYWtlIFdpbjEwIGFjY2VwdCBMaW51eCBOQ00gZ2FkZ2V0IGV0aGVybmV0DQo+ID4gPiA+ID4g
DQo+ID4gPiA+ID4gIGRyaXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi9mX25jbS5jIHwgNDcgKysr
KysrKysrKysrKysrKysrKysrKysrKysrLS0NCj4gPiA+ID4gPiAgZHJpdmVycy91c2IvZ2FkZ2V0
L2Z1bmN0aW9uL3VfbmNtLmggfCAgMyArKw0KPiA+ID4gPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDQ3
IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+ID4gPiANCj4gPiA+IFdoYXQgaXMgdGhl
IGdpdCBjb21taXQgaWQgb2YgdGhpcyBjaGFuZ2UgaW4gTGludXMncyB0cmVlPw0KPiA+ID4gDQo+
ID4gPiB0aGFua3MsDQo+ID4gPiANCj4gPiA+IGdyZWcgay1oDQo+ID4gRm9yIHRoaXMgcGF0Y2g6
DQo+ID4gCTc5MzQwOTI5MjM4MjAyNzIyNjc2OWQwMjk5OTg3ZjA2Y2JkOTdhNmUNCj4gPiANCj4g
PiBhbmQgZm9yICJ1c2I6IGdhZGdldDogZl9uY206IEZpeCBOVFAtMzIgc3VwcG9ydCINCj4gPiAJ
NTUwZWVmMGMzNTMwMzBhYzQyMjNiOWM5NDc5YmRmNzdhMDU0NDVkNg0KPiANCj4gQWgsIHllYWgs
IHRoZXkgZGlkIGdldCBsb3N0IGluIHRoZSBkZWx1Z2UsIHNvcnJ5Lg0KPiANCj4gQ2FuIHlvdSBw
bGVhc2UgcmVzZW5kIHRoZXNlIF93aXRoXyB0aGUgZ2l0IGNvbW1pdCBpZCBpbiB0aGUgbWVzc2Fn
ZSBzbw0KPiB0aGF0IHdlIGtub3cgd2hhdCBpcyBnb2luZyBvbj8NCj4gDQo+IHRoYW5rcywNCj4g
DQo+IGdyZWcgay1oDQoNClJlc2VudCBhcyBQQVRDSHYyIHdpdGggY29tbWl0IGlkJ3MNCg0KICBK
b2NrZQ0K
