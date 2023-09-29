Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 189007B2D06
	for <lists+stable@lfdr.de>; Fri, 29 Sep 2023 09:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232490AbjI2H1a (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 29 Sep 2023 03:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjI2H13 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 29 Sep 2023 03:27:29 -0400
Received: from mo-csw.securemx.jp (mo-csw1800.securemx.jp [210.130.202.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 165781A8
        for <stable@vger.kernel.org>; Fri, 29 Sep 2023 00:27:25 -0700 (PDT)
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 38T7RBDZ1351158; Fri, 29 Sep 2023 16:27:12 +0900
X-Iguazu-Qid: 2yAbeJHejereYO4v6D
X-Iguazu-QSIG: v=2; s=0; t=1695972431; q=2yAbeJHejereYO4v6D; m=To2/pMC+olwaqVxoy8C7+T9zLM3z/u9u/AE6IK02KQM=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
        by relay.securemx.jp (mx-mr1803) id 38T7RBuI2744643
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 29 Sep 2023 16:27:11 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WBLExobsvxk+DSkMBFbRCrnQC9ZV1uEQg5eksP7N0BrDufpc/Uu83FX8Z3nin0TdcO01veW4bGJyirQOi2+8/163PNvx7txkERuEHcEy8xuoTKyvMFzsSbHEA/0KdyOY1YGCrwZI3RPZ6l6NdzXgW2MAVhgT1TmzrGh7BhTmJawGNOduU7QKJqtafJkorNJYJpSYkUtSTNCXOgaMfbxH/6fz3WjT/TVpAkUpQFUARFEeL0youTxMQ3jdmjObnbry54IQFDAQ7q86rT//o6nU9iUXldGhgOteyeUrda8/UxN3xBLTzAQBk1JhdSLCpXeRpiV/LgJypEha6Q/X93o8Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yGcJFd77y0L9gZ4XMwttCdG1E+IN47i4r/npD9IGqgk=;
 b=kDwJ0VAKkoJu6kV78s8BAhsoQYOBt6ck6uulhk6bK/qpv6Hta2G/rOvnUeGIdGkmx398bn9aYUBlWgFq7hM/aD8VU5DpNdpAYSHyqvdgypnfQJE+wr643iIrY9r7ZCm7GAZ+JtPldIZrq+yP1QUXlyFhsGQ8FelW8pVjxysz1QfyGC00z64HVYJe4gGfDwE+IUmELU7XE/lLHJagsJkQSzOuCnnnX7anficN132CRjWg+U1q5IfBrO9roT7i1oJwph9vKQo9PkK0EOIApqY9nGNh++WmLnv82RMq4IU+rcAkMCzxwckX/Jgts/pn9djNVzKVhxqX/wyy2Q5c3VRMLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From:   <nobuhiro1.iwamatsu@toshiba.co.jp>
To:     <niklas.cassel@wdc.com>, <stable@vger.kernel.org>
CC:     <dlemoal@kernel.org>
Subject: RE: [PATCH 4.14.y] ata: libata: disallow dev-initiated LPM
 transitions to unsupported states
Thread-Topic: [PATCH 4.14.y] ata: libata: disallow dev-initiated LPM
 transitions to unsupported states
Thread-Index: AQHZ8iQN94PjqEJFuEqbZm53BEhwO7AxZztQ
Date:   Fri, 29 Sep 2023 07:27:05 +0000
X-TSB-HOP2: ON
Message-ID: <TYCPR01MB9418B505FA508B884166798192C0A@TYCPR01MB9418.jpnprd01.prod.outlook.com>
References: <2023092002-mobster-onset-2af9@gregkh>
 <20230928155357.9807-1-niklas.cassel@wdc.com>
In-Reply-To: <20230928155357.9807-1-niklas.cassel@wdc.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB9418:EE_|TYAPR01MB6171:EE_
x-ms-office365-filtering-correlation-id: 94b8127d-b13f-45e7-3262-08dbc0bd7b89
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: elTIRYhxkJ20t9FyfHwFAFkCYrfLcd4aTlmTtYntOgO+1tHnQQCSwv8jJBjkzSeB71XGi1mca2VxtSRMqDOt4AklDTCuOah6/Jo3R8u7cdtwDxCEgoaqcLoxcr3GwY8SSyuvRxcmtN9NL3yOl61hCNh97Xs9xZI214Pl7eN9YiWge3rm0amI57BHddZRuAajlMRHK8VOgrPhQ0U9EUpqdvASakPcSH3u4Qx9abhgc/k1EaYKpxVvJljnK/XuTxa9P9urvq3Rv+ZiWFH0p15AgNyfAexEO6Ck3utw6vDlNNSkcVDtO1BjaRJoPYLJEc32K8rIOdA8Exh2wWiZwmk4/pREg30SBJaK85Xg8mTSUNhI4bQY3X2dL3XAh5tSmDCBH7F+zX5ySqOqoMhVsHUHD9hPZxXe5KM1X5EHL0RTmKabHuzObcFtmIf9qGPDzNr5ZJ6zI+7wtsbyI8bNFjHjhnaaXZp1AGhHOklVXVfIRoJt1i8RVvbHgSDitBaIAr4WcNsKUrepCk59D6oC3Fg4f7PKF4ye7+dezbr+mUeJbe9bgznDiTOgkNerUvOLDwTL4eBZGhyGliuBsVuoZFnoV4+IB2O/TnInnilQ+ydgOoDXW/c9zqgd408jpAFHMGtv
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB9418.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(39860400002)(346002)(376002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(122000001)(7696005)(5660300002)(4326008)(8936002)(55016003)(41300700001)(83380400001)(52536014)(53546011)(8676002)(316002)(66946007)(71200400001)(64756008)(33656002)(110136005)(66556008)(9686003)(2906002)(26005)(6506007)(86362001)(66446008)(66476007)(38100700002)(76116006)(38070700005)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?enlwQWNFNGVva0duK3hsT3hEOW9DUmhPNk5lbm1xTlYwOTJMSzVHd3NnYWJV?=
 =?utf-8?B?UjlWYUk5eXJmeDA0UG1aMXNNSWIrUnAySFlYeDh0aWNTK0xKN2U2dFhvRDdr?=
 =?utf-8?B?VEJ4Y0hLandwWGt6RU1JR3J5UFhsWHpQQjY1U2dNNVkzQ3dZMXo2Y3JHb3Nu?=
 =?utf-8?B?WDUyN0pLRkFqSk1QTWZrVzJBUE5Sc3pzUnEyYVR1bCtLTCsvRFdRQllXTDVK?=
 =?utf-8?B?L1RDQURPNklkWkl2Y2ZHS0tBMlUwdWRIOVU2WExpWDUxYWpNS2xRSm02WDR2?=
 =?utf-8?B?Vm1JbGxhTXhQN0hIUGFHUUxadkVldU1IZW5iNGc4bk9NVVV4dDJadWhyN042?=
 =?utf-8?B?TTlLQ0hwd09kUy8zV2UrWkpjdG9naW42SVlUL2pUUDVlWUgreGEra0hDZ1N6?=
 =?utf-8?B?M1hIYXczZEkwQXJaOXdFUld5WW1sSk5IQVNiWFRWczErb05QZzV5VzJvaDJ0?=
 =?utf-8?B?OXIyS2pNODJ6Nk1ROTFPMW1DRlYyUnpjWjEvYW1uc1dtTUFjSWtzNnlEUElT?=
 =?utf-8?B?U2ZKbGY4NWd3WjVnV3lUOStLVFArT25FVFdDRjJFeHJMdDU3RTg1MHhQOUdT?=
 =?utf-8?B?TjFhMXd0ZlpkOExDai9DcFNKTmMyZjdobHZDWXhXWmRVL0pwQk1IbzhoTEt2?=
 =?utf-8?B?eTFrdjA5Q3Y2UHBjYUtFeHJPQ1VMRm5FUS9HZS90YnphQ3BKdTEyQVlscUF0?=
 =?utf-8?B?VnFqZDJrUFZDdnRJUUpjOUQrNGV0ZkMvdll2cXlyTTBoeWgrblpCZ1RiejlQ?=
 =?utf-8?B?N2JBU2UyYTZBYW9XODljd011YitqTXdTL09FOFNHbDRKUldtTVFDOHdPSEly?=
 =?utf-8?B?Q0gvMnVHcFlrS3UzRXJLWHRmMHB5N2ZtTGs1T2Z0V3ZBU25BN3ZYbFFPVXhv?=
 =?utf-8?B?UFBYOUE0TkxVbTdzTHRlOWZGT0JHbWRPN2hBdHhUQWN5UmFlay9HcUEyejdz?=
 =?utf-8?B?TE95TXI5TmZ3UCtYbGhrRGs4aGxrSkFZS0FKMzEyeEdvNGt5dGpOYUduMmxS?=
 =?utf-8?B?eHF4STNGME1rZDI0UUVOODl3WDJNL3R6dkZNcEZXL2huZmFabW0wNWhEaE02?=
 =?utf-8?B?anllUzEyTmxVSVdWSVhSeFQrNkhKQUFnTytMcHZRT2ZCSUduRkMxRUZ0dW5Z?=
 =?utf-8?B?RktkL1JyRG9uM1hKUVJuRDBqU0xNU0o2OTk4cTJoZGh6aEkyejVkSU1nUjRZ?=
 =?utf-8?B?NlpyWWRISGdhcjgyRlc3WjZIaGRldkd1enh4OGpXbUwxZkl6UzY1NHo3bENz?=
 =?utf-8?B?QjlGb1VNR1ZoMDBXU3pRZ0NqTmx6ZmdCMlo3bnV5NWZrNklzUk1BaGdXYzEr?=
 =?utf-8?B?b25INDdONjMvSUxBbUJ1Q3ZCN0RYS0pIbmcyRDVrWVUwSE1JOTRhWU9mUkxa?=
 =?utf-8?B?SFVSbzhmdzF0TVBLVVZNK0RHZ1lVR3ZiMmRrQmNJbXl6aHZBQTZiczhXMkJw?=
 =?utf-8?B?UGtQeVJkTWhSR0Z2a2l4MUFQVkpmSWtMS3VvRWFyS3NEbGhvRDE3NTFOc2tr?=
 =?utf-8?B?anl0RDdwMmRsT2ZJMUoyNnpWMlROZUliV3FGS2xHSXN2M2VVeHc2bmd6amMy?=
 =?utf-8?B?Z2N4WlJJbnptS2ordjN2aTZKcDRZalk4TjZYcEo0UFd1TUNGOHNkcHhrbmMx?=
 =?utf-8?B?NG41dW9ISWl3QmgyN1dSOGVqMVpUSktZdnZOeWsvNUFIKzdMdElTZEltWmpv?=
 =?utf-8?B?YkM3RUlsM1hrOHM4aE1INFlBcU9vckRsWTBXSmRERFZYcmdlODlGN0Z2Ylgz?=
 =?utf-8?B?ZVZoekMremFPM0JtR0hmcnNhYjEzRXpoQmZ1ajg2cGFCRU5Yb01vOVo5a0RZ?=
 =?utf-8?B?N0ZtWCtJL1dReE1zM2FmeHFBY09jU2xVQy9OUjNWeTdDaE85SHJWY1dRdzB0?=
 =?utf-8?B?dWlJQWJtSXBtL0dVNHFkdVhGYzk4SmRuZjNnTHRHdHpDclRxTzROaStuOHVH?=
 =?utf-8?B?NEVXUGdVeWlxeGtybDExUXF3MDM1UXh3S1Nmek1LRCtBcFFmZ3cvcjF1Tm1h?=
 =?utf-8?B?cFhnaEZjdFBjdzIyMVZTMm5UUEZDbVh6MllBanZyWWVpbmhwSStOMWJzZ2FO?=
 =?utf-8?B?WVNLakN5UzMvcUF0UzNNMHFGT1FtV2pPaVZGS0FRNU1waTJOL2Q5am4valk0?=
 =?utf-8?B?S1Q3VUxlcnFBalJhTlFhdE15UzUzSmxpWmFXaGpYZGN2REVQdkFMWllab1lP?=
 =?utf-8?B?TkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB9418.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94b8127d-b13f-45e7-3262-08dbc0bd7b89
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2023 07:27:05.6717
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i6rlnEJifCY5VKF610cc6I6bZjT7ycfcd9nTHlZ3dZRtIildFCwKWiFsINLTlNWyl6CgtQPBOxKnESCEnh6vtds9FKMZ2NkZNkE6+l/PUey5bVEDSQxF2TxtV1aTPvHt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB6171
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

SGkhDQoNCllvdSBoYXZlIGZvcmdvdHRlbiB0aGUgdXBzdHJlYW0gY29tbWl0IElELg0KQW5kIHRo
ZXJlIGlzIGEgbWVzc2FnZSBvZiBjaGVycnktcGljayAteC4gVGhpcyBpcyBub3QgbmVjZXNzYXJ5
Lg0KQ291bGQgeW91IHBsZWFzZSBhZGQgY29tbWl0IElEIGFuZCByZW1vdmUgY2hlcnJ5LXBpY2sg
bWVzc2FnZT8NCg0KY29tbWl0IDI0ZTBlNjFkYjNjYjg2YTY2ODI0NTMxOTg5ZjFkZjgwZTA5Mzlm
MjYgdXBzdHJlYW0uDQoNCkJlc3QgcmVnYXJkcywNCiAgTm9idWhpcm8NCg0KPiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBOaWtsYXMgQ2Fzc2VsIDxuaWtsYXMuY2Fzc2VsQHdk
Yy5jb20+DQo+IFNlbnQ6IEZyaWRheSwgU2VwdGVtYmVyIDI5LCAyMDIzIDEyOjU0IEFNDQo+IFRv
OiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+IENjOiBOaWtsYXMgQ2Fzc2VsIDxuaWtsYXMuY2Fz
c2VsQHdkYy5jb20+OyBEYW1pZW4gTGUgTW9hbA0KPiA8ZGxlbW9hbEBrZXJuZWwub3JnPg0KPiBT
dWJqZWN0OiBbUEFUQ0ggNC4xNC55XSBhdGE6IGxpYmF0YTogZGlzYWxsb3cgZGV2LWluaXRpYXRl
ZCBMUE0gdHJhbnNpdGlvbnMgdG8NCj4gdW5zdXBwb3J0ZWQgc3RhdGVzDQo+IA0KPiBJbiBBSENJ
IDEuMy4xLCB0aGUgcmVnaXN0ZXIgZGVzY3JpcHRpb24gZm9yIENBUC5TU0M6DQo+ICJXaGVuIGNs
ZWFyZWQgdG8g4oCYMOKAmSwgc29mdHdhcmUgbXVzdCBub3QgYWxsb3cgdGhlIEhCQSB0byBpbml0
aWF0ZSB0cmFuc2l0aW9ucyB0bw0KPiB0aGUgU2x1bWJlciBzdGF0ZSB2aWEgYWdyZXNzaXZlIGxp
bmsgcG93ZXIgbWFuYWdlbWVudCBub3IgdGhlIFB4Q01ELklDQw0KPiBmaWVsZCBpbiBlYWNoIHBv
cnQsIGFuZCB0aGUgUHhTQ1RMLklQTSBmaWVsZCBpbiBlYWNoIHBvcnQgbXVzdCBiZSBwcm9ncmFt
bWVkDQo+IHRvIGRpc2FsbG93IGRldmljZSBpbml0aWF0ZWQgU2x1bWJlciByZXF1ZXN0cy4iDQo+
IA0KPiBJbiBBSENJIDEuMy4xLCB0aGUgcmVnaXN0ZXIgZGVzY3JpcHRpb24gZm9yIENBUC5QU0M6
DQo+ICJXaGVuIGNsZWFyZWQgdG8g4oCYMOKAmSwgc29mdHdhcmUgbXVzdCBub3QgYWxsb3cgdGhl
IEhCQSB0byBpbml0aWF0ZSB0cmFuc2l0aW9ucyB0bw0KPiB0aGUgUGFydGlhbCBzdGF0ZSB2aWEg
YWdyZXNzaXZlIGxpbmsgcG93ZXIgbWFuYWdlbWVudCBub3IgdGhlIFB4Q01ELklDQyBmaWVsZA0K
PiBpbiBlYWNoIHBvcnQsIGFuZCB0aGUgUHhTQ1RMLklQTSBmaWVsZCBpbiBlYWNoIHBvcnQgbXVz
dCBiZSBwcm9ncmFtbWVkIHRvDQo+IGRpc2FsbG93IGRldmljZSBpbml0aWF0ZWQgUGFydGlhbCBy
ZXF1ZXN0cy4iDQo+IA0KPiBFbnN1cmUgdGhhdCB3ZSBhbHdheXMgc2V0IHRoZSBjb3JyZXNwb25k
aW5nIGJpdHMgaW4gUHhTQ1RMLklQTSwgc3VjaCB0aGF0IGENCj4gZGV2aWNlIGlzIG5vdCBhbGxv
d2VkIHRvIGluaXRpYXRlIHRyYW5zaXRpb25zIHRvIHBvd2VyIHN0YXRlcyB3aGljaCBhcmUNCj4g
dW5zdXBwb3J0ZWQgYnkgdGhlIEhCQS4NCj4gDQo+IERldlNsZWVwIGlzIGFsd2F5cyBpbml0aWF0
ZWQgYnkgdGhlIEhCQSwgaG93ZXZlciwgZm9yIGNvbXBsZXRlbmVzcywgc2V0IHRoZQ0KPiBjb3Jy
ZXNwb25kaW5nIGJpdCBpbiBQeFNDVEwuSVBNIHN1Y2ggdGhhdCBhZ3Jlc3NpdmUgbGluayBwb3dl
ciBtYW5hZ2VtZW50DQo+IGNhbm5vdCB0cmFuc2l0aW9uIHRvIERldlNsZWVwIGlmIERldlNsZWVw
IGlzIG5vdCBzdXBwb3J0ZWQuDQo+IA0KPiBzYXRhX2xpbmtfc2NyX2xwbSgpIGlzIHVzZWQgYnkg
bGliYWhjaSwgYXRhX3BpaXggYW5kIGxpYmF0YS1wbXAuDQo+IEhvd2V2ZXIsIG9ubHkgbGliYWhj
aSBoYXMgdGhlIGFiaWxpdHkgdG8gcmVhZCB0aGUgQ0FQL0NBUDIgcmVnaXN0ZXIgdG8gc2VlIGlm
DQo+IHRoZXNlIGZlYXR1cmVzIGFyZSBzdXBwb3J0ZWQuIFRoZXJlZm9yZSwgaW4gb3JkZXIgdG8g
bm90IGludHJvZHVjZSBhbnkNCj4gcmVncmVzc2lvbnMgb24gYXRhX3BpaXggb3IgbGliYXRhLXBt
cCwgY3JlYXRlIGZsYWdzIHRoYXQgaW5kaWNhdGUgdGhhdCB0aGUNCj4gcmVzcGVjdGl2ZSBmZWF0
dXJlIGlzIE5PVCBzdXBwb3J0ZWQuIFRoaXMgd2F5LCB0aGUgYmVoYXZpb3IgZm9yIGF0YV9waWl4
IGFuZA0KPiBsaWJhdGEtcG1wIHNob3VsZCByZW1haW4gdW5jaGFuZ2VkLg0KPiANCj4gVGhpcyBj
aGFuZ2UgaXMgYmFzZWQgb24gYSBwYXRjaCBvcmlnaW5hbGx5IHN1Ym1pdHRlZCBieSBSdW5hIEd1
by1vYy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE5pa2xhcyBDYXNzZWwgPG5pa2xhcy5jYXNzZWxA
d2RjLmNvbT4NCj4gRml4ZXM6IDExNTJiMjYxN2E2ZSAoImxpYmF0YTogaW1wbGVtZW50IHNhdGFf
bGlua19zY3JfbHBtKCkgYW5kIG1ha2UNCj4gYXRhX2Rldl9zZXRfZmVhdHVyZSgpIGdsb2JhbCIp
DQo+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+IFNpZ25lZC1vZmYtYnk6IERhbWllbiBM
ZSBNb2FsIDxkbGVtb2FsQGtlcm5lbC5vcmc+IChjaGVycnkgcGlja2VkIGZyb20NCj4gY29tbWl0
IDI0ZTBlNjFkYjNjYjg2YTY2ODI0NTMxOTg5ZjFkZjgwZTA5MzlmMjYpDQo+IFNpZ25lZC1vZmYt
Ynk6IE5pa2xhcyBDYXNzZWwgPG5pa2xhcy5jYXNzZWxAd2RjLmNvbT4NCj4gLS0tDQo+ICBkcml2
ZXJzL2F0YS9haGNpLmMgICAgICAgIHwgIDkgKysrKysrKysrDQo+ICBkcml2ZXJzL2F0YS9saWJh
dGEtY29yZS5jIHwgMTkgKysrKysrKysrKysrKysrKy0tLQ0KPiAgaW5jbHVkZS9saW51eC9saWJh
dGEuaCAgICB8ICA0ICsrKysNCj4gIDMgZmlsZXMgY2hhbmdlZCwgMjkgaW5zZXJ0aW9ucygrKSwg
MyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2F0YS9haGNpLmMgYi9k
cml2ZXJzL2F0YS9haGNpLmMgaW5kZXgNCj4gMDkwNWMwN2I4YzdlLi5hYmIzZGQwNDg1NTYgMTAw
NjQ0DQo+IC0tLSBhL2RyaXZlcnMvYXRhL2FoY2kuYw0KPiArKysgYi9kcml2ZXJzL2F0YS9haGNp
LmMNCj4gQEAgLTE3NzcsNiArMTc3NywxNSBAQCBzdGF0aWMgaW50IGFoY2lfaW5pdF9vbmUoc3Ry
dWN0IHBjaV9kZXYgKnBkZXYsIGNvbnN0DQo+IHN0cnVjdCBwY2lfZGV2aWNlX2lkICplbnQpDQo+
ICAJZWxzZQ0KPiAgCQlkZXZfaW5mbygmcGRldi0+ZGV2LCAiU1NTIGZsYWcgc2V0LCBwYXJhbGxl
bCBidXMgc2Nhbg0KPiBkaXNhYmxlZFxuIik7DQo+IA0KPiArCWlmICghKGhwcml2LT5jYXAgJiBI
T1NUX0NBUF9QQVJUKSkNCj4gKwkJaG9zdC0+ZmxhZ3MgfD0gQVRBX0hPU1RfTk9fUEFSVDsNCj4g
Kw0KPiArCWlmICghKGhwcml2LT5jYXAgJiBIT1NUX0NBUF9TU0MpKQ0KPiArCQlob3N0LT5mbGFn
cyB8PSBBVEFfSE9TVF9OT19TU0M7DQo+ICsNCj4gKwlpZiAoIShocHJpdi0+Y2FwMiAmIEhPU1Rf
Q0FQMl9TRFMpKQ0KPiArCQlob3N0LT5mbGFncyB8PSBBVEFfSE9TVF9OT19ERVZTTFA7DQo+ICsN
Cj4gIAlpZiAocGkuZmxhZ3MgJiBBVEFfRkxBR19FTSkNCj4gIAkJYWhjaV9yZXNldF9lbShob3N0
KTsNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2F0YS9saWJhdGEtY29yZS5jIGIvZHJpdmVy
cy9hdGEvbGliYXRhLWNvcmUuYyBpbmRleA0KPiAwOGRjMzdhNjJmNWEuLjY5MDAyYWQxNTUwMCAx
MDA2NDQNCj4gLS0tIGEvZHJpdmVycy9hdGEvbGliYXRhLWNvcmUuYw0KPiArKysgYi9kcml2ZXJz
L2F0YS9saWJhdGEtY29yZS5jDQo+IEBAIC0zOTkzLDEwICszOTkzLDIzIEBAIGludCBzYXRhX2xp
bmtfc2NyX2xwbShzdHJ1Y3QgYXRhX2xpbmsgKmxpbmssIGVudW0NCj4gYXRhX2xwbV9wb2xpY3kg
cG9saWN5LA0KPiAgCQlzY29udHJvbCB8PSAoMHg2IDw8IDgpOw0KPiAgCQlicmVhazsNCj4gIAlj
YXNlIEFUQV9MUE1fTUlOX1BPV0VSOg0KPiAtCQlpZiAoYXRhX2xpbmtfbnJfZW5hYmxlZChsaW5r
KSA+IDApDQo+IC0JCQkvKiBubyByZXN0cmljdGlvbnMgb24gTFBNIHRyYW5zaXRpb25zICovDQo+
ICsJCWlmIChhdGFfbGlua19ucl9lbmFibGVkKGxpbmspID4gMCkgew0KPiArCQkJLyogYXNzdW1l
IG5vIHJlc3RyaWN0aW9ucyBvbiBMUE0gdHJhbnNpdGlvbnMgKi8NCj4gIAkJCXNjb250cm9sICY9
IH4oMHg3IDw8IDgpOw0KPiAtCQllbHNlIHsNCj4gKw0KPiArCQkJLyoNCj4gKwkJCSAqIElmIHRo
ZSBjb250cm9sbGVyIGRvZXMgbm90IHN1cHBvcnQgcGFydGlhbCwgc2x1bWJlciwNCj4gKwkJCSAq
IG9yIGRldnNsZWVwLCB0aGVuIGRpc2FsbG93IHRoZXNlIHRyYW5zaXRpb25zLg0KPiArCQkJICov
DQo+ICsJCQlpZiAobGluay0+YXAtPmhvc3QtPmZsYWdzICYgQVRBX0hPU1RfTk9fUEFSVCkNCj4g
KwkJCQlzY29udHJvbCB8PSAoMHgxIDw8IDgpOw0KPiArDQo+ICsJCQlpZiAobGluay0+YXAtPmhv
c3QtPmZsYWdzICYgQVRBX0hPU1RfTk9fU1NDKQ0KPiArCQkJCXNjb250cm9sIHw9ICgweDIgPDwg
OCk7DQo+ICsNCj4gKwkJCWlmIChsaW5rLT5hcC0+aG9zdC0+ZmxhZ3MgJg0KPiBBVEFfSE9TVF9O
T19ERVZTTFApDQo+ICsJCQkJc2NvbnRyb2wgfD0gKDB4NCA8PCA4KTsNCj4gKwkJfSBlbHNlIHsN
Cj4gIAkJCS8qIGVtcHR5IHBvcnQsIHBvd2VyIG9mZiAqLw0KPiAgCQkJc2NvbnRyb2wgJj0gfjB4
ZjsNCj4gIAkJCXNjb250cm9sIHw9ICgweDEgPDwgMik7DQo+IGRpZmYgLS1naXQgYS9pbmNsdWRl
L2xpbnV4L2xpYmF0YS5oIGIvaW5jbHVkZS9saW51eC9saWJhdGEuaCBpbmRleA0KPiAwZTlmOGZk
MzdlYjkuLmFiMmM1ZDZjYWJlZCAxMDA2NDQNCj4gLS0tIGEvaW5jbHVkZS9saW51eC9saWJhdGEu
aA0KPiArKysgYi9pbmNsdWRlL2xpbnV4L2xpYmF0YS5oDQo+IEBAIC0yNzksNiArMjc5LDEwIEBA
IGVudW0gew0KPiAgCUFUQV9IT1NUX1BBUkFMTEVMX1NDQU4JPSAoMSA8PCAyKSwJLyogUG9ydHMg
b24gdGhpcyBob3N0DQo+IGNhbiBiZSBzY2FubmVkIGluIHBhcmFsbGVsICovDQo+ICAJQVRBX0hP
U1RfSUdOT1JFX0FUQQk9ICgxIDw8IDMpLAkvKiBJZ25vcmUgQVRBDQo+IGRldmljZXMgb24gdGhp
cyBob3N0LiAqLw0KPiANCj4gKwlBVEFfSE9TVF9OT19QQVJUCT0gKDEgPDwgNCksIC8qIEhvc3Qg
ZG9lcyBub3Qgc3VwcG9ydCBwYXJ0aWFsICovDQo+ICsJQVRBX0hPU1RfTk9fU1NDCQk9ICgxIDw8
IDUpLCAvKiBIb3N0IGRvZXMgbm90IHN1cHBvcnQNCj4gc2x1bWJlciAqLw0KPiArCUFUQV9IT1NU
X05PX0RFVlNMUAk9ICgxIDw8IDYpLCAvKiBIb3N0IGRvZXMgbm90IHN1cHBvcnQNCj4gZGV2c2xw
ICovDQo+ICsNCj4gIAkvKiBiaXRzIDI0OjMxIG9mIGhvc3QtPmZsYWdzIGFyZSByZXNlcnZlZCBm
b3IgTExEIHNwZWNpZmljIGZsYWdzICovDQo+IA0KPiAgCS8qIHZhcmlvdXMgbGVuZ3RocyBvZiB0
aW1lICovDQo+IC0tDQo+IDIuNDEuMA0K

